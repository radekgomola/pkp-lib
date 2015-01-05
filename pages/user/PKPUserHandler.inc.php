<?php

/**
 * @file pages/user/PKPUserHandler.inc.php
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2000-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class PKPUserHandler
 * @ingroup pages_user
 *
 * @brief Handle requests for user functions.
 */

import('classes.handler.Handler');

class PKPUserHandler extends Handler {
	/**
	 * Constructor
	 */
	function PKPUserHandler() {
		parent::Handler();
	}

	/**
	 * Change the locale for the current user.
	 * @param $args array first parameter is the new locale
	 */
	function setLocale($args, $request) {
		$setLocale = array_shift($args);

		$site = $request->getSite();
		$context = $request->getContext();
		if ($context != null) {
			$contextSupportedLocales = (array) $context->getSupportedLocales();
		}

		if (AppLocale::isLocaleValid($setLocale) && (!isset($contextSupportedLocales) || in_array($setLocale, $contextSupportedLocales)) && in_array($setLocale, $site->getSupportedLocales())) {
			$session = $request->getSession();
			$session->setSessionVar('currentLocale', $setLocale);
		}

		if(isset($_SERVER['HTTP_REFERER'])) {
			$request->redirectUrl($_SERVER['HTTP_REFERER']);
		}

		$request->redirect(null, 'index');
	}

	/**
	 * Get keywords for reviewer interests autocomplete.
	 * @param $args array
	 * @param $request PKPRequest
	 * @return string Serialized JSON object
	 */
	function getInterests($args, $request) {
		// Get the input text used to filter on
		$filter = $request->getUserVar('term');

		import('lib.pkp.classes.user.InterestManager');
		$interestManager = new InterestManager();

		$interests = $interestManager->getAllInterests($filter);

		import('lib.pkp.classes.core.JSONMessage');
		$json = new JSONMessage(true, $interests);
		return $json->getString();
	}

	/**
	 * Persist the status for a user's preference to see inline help.
	 * @param $args array
	 * @param $request PKPRequest
	 * @return string Serialized JSON object
	 */
	function toggleHelp($args, $request) {

		$user = $request->getUser();
		$user->setInlineHelp($user->getInlineHelp() ? 0 : 1);

		$userDao = DAORegistry::getDAO('UserDAO');
		$userDao->updateObject($user);

		import('lib.pkp.classes.core.JSONMessage');
		$json = new JSONMessage(true);
		return $json->getString();
	}

	/**
	 * Display an authorization denied message.
	 * @param $args array
	 * @param $request Request
	 */
	function authorizationDenied($args, $request) {
		if (!Validation::isLoggedIn()) {
			Validation::redirectLogin();
		}

		// Get message with sanity check (for XSS or phishing)
		$authorizationMessage = $request->getUserVar('message');
		if (!preg_match('/^[a-zA-Z0-9.]+$/', $authorizationMessage)) {
			fatalError('Invalid locale key for auth message.');
		}

		$this->setupTemplate($request);
		AppLocale::requireComponents(LOCALE_COMPONENT_PKP_USER);
		$templateMgr = TemplateManager::getManager($request);
		$templateMgr->assign('message', $authorizationMessage);
		return $templateMgr->display('common/message.tpl');
	}
}

?>
