<?php

/**
 * @file pages/workflow/PKPWorkflowHandler.inc.php
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class WorkflowHandler
 * @ingroup pages_reviewer
 *
 * @brief Handle requests for the submssion workflow.
 */

import('classes.handler.Handler');

// import UI base classes
import('lib.pkp.classes.linkAction.LinkAction');
import('lib.pkp.classes.linkAction.request.AjaxModal');

abstract class PKPWorkflowHandler extends Handler {
	/**
	 * Constructor
	 */
	function PKPWorkflowHandler() {
		parent::Handler();
	}


	//
	// Implement template methods from PKPHandler
	//
	/**
	 * @copydoc PKPHandler::authorize()
	 */
	function authorize($request, &$args, $roleAssignments) {
		$router = $request->getRouter();
		$operation = $router->getRequestedOp($request);

		if ($operation == 'access' || $operation == 'expedite') {
			// Authorize requested submission.
			import('lib.pkp.classes.security.authorization.internal.SubmissionRequiredPolicy');
			$this->addPolicy(new SubmissionRequiredPolicy($request, $args, 'submissionId'));

			// This policy will deny access if user has no accessible workflow stage.
			// Otherwise it will build an authorized object with all accessible
			// workflow stages and authorize user operation access.
			import('classes.security.authorization.internal.UserAccessibleWorkflowStageRequiredPolicy');
			$this->addPolicy(new UserAccessibleWorkflowStageRequiredPolicy($request));
		} else {
			import('classes.security.authorization.WorkflowStageAccessPolicy');
			$this->addPolicy(new WorkflowStageAccessPolicy($request, $args, $roleAssignments, 'submissionId', $this->_identifyStageId($request)));
		}

		return parent::authorize($request, $args, $roleAssignments);
	}

	/**
	 * @copydoc PKPHandler::initialize()
	 */
	function initialize($request, $args) {
		$router = $request->getRouter();
		$operation = $router->getRequestedOp($request);

		if ($operation != 'access') {
			$this->setupTemplate($request);
		}

		// Call parent method.
		parent::initialize($request, $args);
	}


	//
	// Public handler methods
	//
	/**
	 * Redirect users to their most appropriate
	 * submission workflow stage.
	 */
	function access($args, $request) {
		$submission = $this->getAuthorizedContextObject(ASSOC_TYPE_SUBMISSION);
		$userGroupDao = DAORegistry::getDAO('UserGroupDAO');
		$reviewRoundDao = DAORegistry::getDAO('ReviewRoundDAO');

		$stageId = $submission->getStageId();
		$accessibleWorkflowStages = $this->getAuthorizedContextObject(ASSOC_TYPE_ACCESSIBLE_WORKFLOW_STAGES);

		// Get the closest workflow stage that user has an assignment.
		$stagePath = null;
		for ($workingStageId = $stageId; $workingStageId >= WORKFLOW_STAGE_ID_SUBMISSION; $workingStageId--) {
			if (array_key_exists($workingStageId, $accessibleWorkflowStages)) {
				$stagePath = $userGroupDao->getPathFromId($workingStageId);
				break;
			}
		}

		// If no stage was found, user still have access to future stages of the
		// submission. Try to get the closest future workflow stage.
		if (!$stagePath) {
			for ($workingStageId = $stageId; $workingStageId <= WORKFLOW_STAGE_ID_PRODUCTION; $workingStageId++) {
				if (array_key_exists($workingStageId, $accessibleWorkflowStages)) {
					$stagePath = $userGroupDao->getPathFromId($workingStageId);
					break;
				}
			}
		}

		assert(!is_null($stagePath));

		$router = $request->getRouter();
		$request->redirectUrl($router->url($request, null, 'workflow', $stagePath, $submission->getId()));
	}

	/**
	 * Show the submission stage.
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function submission($args, $request) {
		// Render the view.
		$templateMgr = TemplateManager::getManager($request);
		$templateMgr->display('workflow/submission.tpl');
	}

	/**
	 * Show the external review stage.
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function externalReview($args, $request) {
		// Use different ops so we can identify stage by op.
		$templateMgr = TemplateManager::getManager($request);
		$templateMgr->assign('reviewRoundOp', 'externalReviewRound');
		return $this->_review($args, $request);
	}

	/**
	 * Show the editorial stage
	 * @param $request PKPRequest
	 * @param $args array
	 */
	function editorial(&$args, $request) {
		// Render the view.
		$templateMgr = TemplateManager::getManager($request);
		$templateMgr->display('workflow/editorial.tpl');
	}

	/**
	 * Expedites a submission through the submission process, if the submitter is a manager or editor.
	 *  Implemented in sub classes.
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function expedite($args, $request) {
		assert(false);
	}

	/**
	 * Fetch JSON-encoded editor decision options.
	 * @param $args array
	 * @param $request Request
	 */
	function editorDecisionActions($args, $request) {
		AppLocale::requireComponents(LOCALE_COMPONENT_APP_EDITOR);
		$reviewRoundId = (int) $request->getUserVar('reviewRoundId');

		// Prepare the action arguments.
		$submission = $this->getAuthorizedContextObject(ASSOC_TYPE_SUBMISSION);
		$stageId = $this->getAuthorizedContextObject(ASSOC_TYPE_WORKFLOW_STAGE);

		$actionArgs = array(
			'submissionId' => $submission->getId(),
			'stageId' => (int) $stageId,
		);

		// If a review round was specified, include it in the args;
		// must also check that this is the last round or decisions
		// cannot be recorded.
		if ($reviewRoundId) {
			$actionArgs['reviewRoundId'] = $reviewRoundId;
			$reviewRoundDao = DAORegistry::getDAO('ReviewRoundDAO');
			$lastReviewRound = $reviewRoundDao->getLastReviewRoundBySubmissionId($submission->getId(), $stageId);
		}

		// If a review round was specified,

		// If there is an editor assigned, retrieve stage decisions.
		$stageAssignmentDao = DAORegistry::getDAO('StageAssignmentDAO');
		if ($stageAssignmentDao->editorAssignedToStage($submission->getId(), $stageId) && (!$reviewRoundId || $reviewRoundId == $lastReviewRound->getId())) {
			import('classes.workflow.EditorDecisionActionsManager');
			$decisions = EditorDecisionActionsManager::getStageDecisions($stageId);
		} else {
			$decisions = array(); // None available
		}

		// Iterate through the editor decisions and create a link action for each decision.
		$editorActions = array();
		$dispatcher = $request->getDispatcher();
		import('lib.pkp.classes.linkAction.request.AjaxModal');
		foreach($decisions as $decision => $action) {
			$actionArgs['decision'] = $decision;
			$editorActions[] = new LinkAction(
				$action['name'],
				new AjaxModal(
					$dispatcher->url(
						$request, ROUTE_COMPONENT, null,
						'modals.editorDecision.EditorDecisionHandler',
						$action['operation'], null, $actionArgs
					),
					__($action['title']),
					$action['titleIcon']
				),
				__($action['title'])
			);
		}

		// Assign the actions to the template.
		$templateMgr = TemplateManager::getManager($request);
		$templateMgr->assign('editorActions', $editorActions);
		$templateMgr->assign('stageId', $stageId);
		return $templateMgr->fetchJson('workflow/editorialLinkActions.tpl');
	}

	/**
	* Fetch the JSON-encoded submission header.
	* @param $args array
	* @param $request Request
	*/
	function submissionHeader($args, $request) {
		$templateMgr = TemplateManager::getManager($request);
		return $templateMgr->fetchJson('workflow/submissionHeader.tpl');
	}

	/**
	* Fetch the JSON-encoded submission progress bar.
	* @param $args array
	* @param $request Request
	*/
	function submissionProgressBar($args, $request) {
		$templateMgr = TemplateManager::getManager($request);
		$context = $request->getContext();

		$userGroupDao = DAORegistry::getDAO('UserGroupDAO');
		$workflowStages = $userGroupDao->getWorkflowStageKeysAndPaths();
		$stageNotifications = array();
		foreach (array_keys($workflowStages) as $stageId) {
			$stageNotifications[$stageId] = $this->notificationOptionsByStage($request->getUser(), $stageId, $context->getId());
		}

		$templateMgr->assign('stageNotifications', $stageNotifications);

		$submission = $this->getAuthorizedContextObject(ASSOC_TYPE_SUBMISSION);
		if ($this->isSubmissionReady($submission)) {
			$templateMgr->assign('submissionIsReady', true);
		}

		return $templateMgr->fetchJson('workflow/submissionProgressBar.tpl');
	}

	/**
	 * Setup variables for the template
	 * @param $request Request
	 */
	function setupTemplate($request) {
		parent::setupTemplate($request);
		AppLocale::requireComponents(LOCALE_COMPONENT_PKP_SUBMISSION, LOCALE_COMPONENT_APP_SUBMISSION, LOCALE_COMPONENT_APP_EDITOR, LOCALE_COMPONENT_PKP_GRID, LOCALE_COMPONENT_PKP_EDITOR);

		$router = $request->getRouter();

		$submission =& $this->getAuthorizedContextObject(ASSOC_TYPE_SUBMISSION);
		$stageId = $this->getAuthorizedContextObject(ASSOC_TYPE_WORKFLOW_STAGE);

		// Construct array with workflow stages data.
		$userGroupDao = DAORegistry::getDAO('UserGroupDAO');
		$workflowStages = $userGroupDao->getWorkflowStageKeysAndPaths();

		$templateMgr = TemplateManager::getManager($request);

		// Assign the authorized submission.
		$templateMgr->assign('submission', $submission);

		// Assign workflow stages related data.
		$templateMgr->assign('stageId', $stageId);
		$templateMgr->assign('submissionStageId', $submission->getStageId());
		$templateMgr->assign('workflowStages', $workflowStages);

		// Get the right notifications type based on current stage id.
		$notificationMgr = new NotificationManager();
		$editorAssignmentNotificationType = $this->getEditorAssignmentNotificationTypeByStageId($stageId);

		// Define the workflow notification options.
		$notificationRequestOptions = array(
				NOTIFICATION_LEVEL_TASK => array(
						$editorAssignmentNotificationType => array(ASSOC_TYPE_SUBMISSION, $submission->getId())
				),
				NOTIFICATION_LEVEL_TRIVIAL => array()
		);

		$signoffNotificationType = $this->_getSignoffNotificationTypeByStageId($stageId);
		if (!is_null($signoffNotificationType)) {
			$notificationRequestOptions[NOTIFICATION_LEVEL_TASK][$signoffNotificationType] = array(ASSOC_TYPE_SUBMISSION, $submission->getId());
		}

		$templateMgr->assign('workflowNotificationRequestOptions', $notificationRequestOptions);

		import('controllers.modals.submissionMetadata.linkAction.SubmissionEntryLinkAction');
		$templateMgr->assign(
				'submissionEntryAction',
				new SubmissionEntryLinkAction($request, $submission->getId(), $stageId)
		);

		import('lib.pkp.controllers.informationCenter.linkAction.SubmissionInfoCenterLinkAction');
		$templateMgr->assign(
				'submissionInformationCenterAction',
				new SubmissionInfoCenterLinkAction($request, $submission->getId())
		);
	}

	//
	// Protected helper methods
	//
	/**
	 * Internal function to handle both internal and external reviews
	 * @param $request PKPRequest
	 * @param $args array
	 */
	protected function _review($args, $request) {
		// Retrieve the authorized submission and stage id.
		$submission = $this->getAuthorizedContextObject(ASSOC_TYPE_SUBMISSION);
		$selectedStageId = $this->getAuthorizedContextObject(ASSOC_TYPE_WORKFLOW_STAGE);

		$templateMgr = TemplateManager::getManager($request);

		// Get all review rounds for this submission, on the current stage.
		$reviewRoundDao = DAORegistry::getDAO('ReviewRoundDAO');
		$reviewRoundsFactory = $reviewRoundDao->getBySubmissionId($submission->getId(), $selectedStageId);
		if (!$reviewRoundsFactory->wasEmpty()) {
			$reviewRoundsArray = $reviewRoundsFactory->toAssociativeArray();

			// Get the review round number of the last review round to be used
			// as the current review round tab index.
			$lastReviewRoundNumber = end($reviewRoundsArray)->getRound();
			$lastReviewRoundId = end($reviewRoundsArray)->getId();
			reset($reviewRoundsArray);

			// Add the round information to the template.
			$templateMgr->assign('reviewRounds', $reviewRoundsArray);
			$templateMgr->assign('lastReviewRoundNumber', $lastReviewRoundNumber);

			if ($submission->getStageId() == $selectedStageId) {
				$dispatcher = $request->getDispatcher();
				$newRoundAction = new LinkAction(
					'newRound',
					new AjaxModal(
						$dispatcher->url(
							$request, ROUTE_COMPONENT, null,
							'modals.editorDecision.EditorDecisionHandler',
							'newReviewRound', null, array(
								'submissionId' => $submission->getId(),
								'decision' => SUBMISSION_EDITOR_DECISION_RESUBMIT,
								'stageId' => $selectedStageId,
								'reviewRoundId' => $lastReviewRoundId
							)
						),
						__('editor.submission.newRound'),
						'modal_add_item'
					),
					__('editor.submission.newRound'),
					'add_item_small'
				);
				$templateMgr->assign('newRoundAction', $newRoundAction);
			}
		}

		// Render the view.
		$templateMgr->display('workflow/review.tpl');
	}

	/**
	 * Translate the requested operation to a stage id.
	 * @param $request Request
	 * @return integer One of the WORKFLOW_STAGE_* constants.
	 */
	protected function _identifyStageId($request) {
		if ($stageId = $request->getUserVar('stageId')) {
			return (int) $stageId;
		}

		// Retrieve the requested operation.
		$router = $request->getRouter();
		$operation = $router->getRequestedOp($request);

		// Translate the operation to a workflow stage identifier.
		$userGroupDao = DAORegistry::getDAO('UserGroupDAO');
		return $userGroupDao->getIdFromPath($operation);
	}

	/**
	 * Determine if a particular stage has a notification pending.  If so, return true.
	 * This is used to set the CSS class of the submission progress bar.
	 * @param $user PKPUser
	 * @param $stageId integer
	 * @param $contextId integer
	 */
	protected function notificationOptionsByStage($user, $stageId, $contextId) {
		$submission = $this->getAuthorizedContextObject(ASSOC_TYPE_SUBMISSION);
		$notificationDao = DAORegistry::getDAO('NotificationDAO');

		$signOffNotificationType = $this->_getSignoffNotificationTypeByStageId($stageId);
		$editorAssignmentNotificationType = $this->getEditorAssignmentNotificationTypeByStageId($stageId);

		$editorAssignments = $notificationDao->getByAssoc(ASSOC_TYPE_SUBMISSION, $submission->getId(), null, $editorAssignmentNotificationType, $contextId);
		if (isset($signOffNotificationType)) {
			$signoffAssignments = $notificationDao->getByAssoc(ASSOC_TYPE_SUBMISSION, $submission->getId(), $user->getId(), $signOffNotificationType, $contextId);
		}

		// if the User has assigned TASKs in this stage check, return true
		if (!$editorAssignments->wasEmpty() || (isset($signoffAssignments) && !$signoffAssignments->wasEmpty())) {
			return true;
		}

		// check for more specific notifications on those stages that have them.
		if ($stageId == WORKFLOW_STAGE_ID_PRODUCTION) {
			$submissionApprovalNotification = $notificationDao->getByAssoc(ASSOC_TYPE_SUBMISSION, $submission->getId(), null, NOTIFICATION_TYPE_APPROVE_SUBMISSION, $contextId);
			if (!$submissionApprovalNotification->wasEmpty()) {
				return true;
			}
		}

		if ($stageId == WORKFLOW_STAGE_ID_EXTERNAL_REVIEW || $stageId == WORKFLOW_STAGE_ID_EXTERNAL_REVIEW) {
			$reviewRoundDao = DAORegistry::getDAO('ReviewRoundDAO');
			$reviewRounds = $reviewRoundDao->getBySubmissionId($submission->getId(), $stageId);
			$notificationTypes = array(NOTIFICATION_TYPE_REVIEW_ROUND_STATUS, NOTIFICATION_TYPE_ALL_REVIEWS_IN);
			while ($reviewRound = $reviewRounds->next()) {
				foreach ($notificationTypes as $type) {
					$notifications = $notificationDao->getByAssoc(ASSOC_TYPE_REVIEW_ROUND, $reviewRound->getId(), null, $type, $contextId);
					if (!$notifications->wasEmpty()) {
						return true;
					}
				}
			}
		}

		return false;
	}


	//
	// Abstract protected methods.
	//
	/**
	* Return the editor assignment notification type based on stage id.
	* @param $stageId int
	* @return int
	*/
	abstract protected function getEditorAssignmentNotificationTypeByStageId($stageId);

	/**
	 * Checks whether or not the submission is ready to appear in catalog.
	 * @param $submission Submission
	 * @return boolean
	 */
	abstract protected function isSubmissionReady($submission);


	//
	// Private helper methods.
	//
	/**
	* Return the signoff notification type based on stage id.
	* @param $stageId
	* @return int
	*/
	private function _getSignoffNotificationTypeByStageId($stageId) {
		switch ($stageId) {
			case WORKFLOW_STAGE_ID_EDITING:
				return NOTIFICATION_TYPE_SIGNOFF_COPYEDIT;
			case WORKFLOW_STAGE_ID_PRODUCTION:
				return NOTIFICATION_TYPE_SIGNOFF_PROOF;
		}
		return null;
	}
}

?>
