<?php

/**
 * @file classes/notification/managerDelegate/AuditorRequestNotificationManager.inc.php
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class AuditorRequestNotificationManager
 * @ingroup managerDelegate
 *
 * @brief Auditor request notification types manager delegate.
 */

import('lib.pkp.classes.notification.managerDelegate.signoff.SignoffNotificationManager');

class AuditorRequestNotificationManager extends SignoffNotificationManager {

	/**
	 * Constructor.
	 * @param $notificationType int NOTIFICATION_TYPE_...
	*/
	function AuditorRequestNotificationManager($notificationType) {
		parent::SignoffNotificationManager($notificationType);
	}

	/**
	 * @copydoc PKPNotificationOperationManager::getNotificationMessage()
	 */
	function getNotificationMessage($request, $notification) {
		$signoffDao = DAORegistry::getDAO('SignoffDAO'); /* @var $signoffDao SignoffDAO */
		$signoff = $signoffDao->getById($notification->getAssocId());
		assert($signoff->getAssocType() == ASSOC_TYPE_SUBMISSION_FILE);

		$submissionFileDao = DAORegistry::getDAO('SubmissionFileDAO');
		$submissionFile = $submissionFileDao->getLatestRevision($signoff->getAssocId());
		return __('notification.type.auditorRequest', array('file' => $submissionFile->getLocalizedName()));
	}

	/**
	 * @copydoc PKPNotificationOperationManager::getStyleClass()
	 */
	function getStyleClass($notification) {
		return NOTIFICATION_STYLE_CLASS_WARNING;
	}

	/**
	 * @copydoc NotificationManagerDelegate::updateNotification()
	 */
	public function updateNotification($request, $userIds, $assocType, $assocId) {
		$userId = !is_null($userIds) ? current($userIds) : null;

		// Check for an existing notification.
		$notificationDao = DAORegistry::getDAO('NotificationDAO');
		$notificationFactory = $notificationDao->getByAssoc(
			ASSOC_TYPE_SIGNOFF,
			$assocId,
			$userId,
			NOTIFICATION_TYPE_AUDITOR_REQUEST
		);

		// Check for the complete state of the signoff.
		$signoffDao = DAORegistry::getDAO('SignoffDAO'); /* @var $signoffDao SignoffDAO */
		$signoff = $signoffDao->getById($assocId);

		$signoffCompleted = false;
		$removed = false;
		if (!$signoff) {
			$removed = true;
		} else {
			if (!is_null($signoff->getDateCompleted())) {
				$signoffCompleted = true;
			}
		}

		// Decide if we have to create or delete a notification.
		if (($signoffCompleted || $removed) && !$notificationFactory->wasEmpty()) {
			$notification = $notificationFactory->next();
			$notificationDao->deleteObject($notification);
		}  else if (!$signoffCompleted && $notificationFactory->wasEmpty()) {
			$context = $request->getContext();
			$this->createNotification(
				$request,
				$userId,
				NOTIFICATION_TYPE_AUDITOR_REQUEST,
				$context->getId(),
				ASSOC_TYPE_SIGNOFF,
				$assocId,
				NOTIFICATION_LEVEL_TASK
			);
		}
	}
}

?>
