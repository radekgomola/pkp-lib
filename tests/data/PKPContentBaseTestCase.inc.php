<?php

/**
 * @file tests/data/PKPContentBaseTestCase.inc.php
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2000-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class PKPContentBaseTestCase
 * @ingroup tests_data
 *
 * @brief Data build suite: Base class for content creation tests (PKP base)
 */

import('lib.pkp.tests.WebTestCase');

abstract class PKPContentBaseTestCase extends WebTestCase {
	/**
	 * Handle any section information on submission step 1
	 * @return string
	 */
	protected function _handleStep1($data) {
	}

	/**
	 * Handle any section information on submission step 3
	 * @return string
	 */
	protected function _handleStep3($data) {
	}

	/**
	 * Get the number of items in the default submission checklist
	 * @return int
	 */
	abstract protected function _getChecklistLength();

	/**
	 * Get the submission submission element's name
	 * @return string
	 */
	abstract protected function _getSubmissionElementName();

	/**
	 * Create a submission with the supplied data.
	 * @param $data array Associative array of submission information
	 */
	protected function createSubmission($data) {
		// Check that the required parameters are provided
		foreach (array(
			'title',
		) as $paramName) {
			$this->assertTrue(isset($data[$paramName]));
		}

		$data = array_merge(array(
			'file' => null,
			'fileTitle' => $data['title'],
			'keywords' => array(),
			'additionalAuthors' => array(),
		), $data);

		// Find the "start a submission" button
		$this->waitForElementPresent('//span[starts-with(., \'Start a New Submission\')]/..');
		$this->click('//span[starts-with(., \'Start a New Submission\')]/..');

		// Check the default checklist items.
		$this->waitForElementPresent('id=checklist-0');
		for ($i=0; $i<$this->_getChecklistLength(); $i++) $this->click('id=checklist-' . $i);

		// Permit the subclass to handle any extra step 1 actions
		$this->_handleStep1($data);

		$this->clickAndWait('css=[id^=submitFormButton-]');

		// Page 2: File wizard
		sleep(1); // Occasional race conditions in travis
		$this->uploadWizardFile($data['fileTitle'], $data['file']);
		sleep(1); // Occasional race conditions in travis

		$this->waitForElementPresent('//span[text()=\'Save and continue\']/..');
		$this->click('//span[text()=\'Save and continue\']/..');

		// Page 3
		sleep(1); // Occasional race conditions in travis
		$this->waitForElementPresent('css=[id^=title-]');
		$this->type('css=[id^=title-]', $data['title']);
		if (isset($data['abstract'])) $this->typeTinyMCE('abstract', $data['abstract']);
		foreach ($data['keywords'] as $tag) $this->addTag('keyword', $tag);

		foreach ($data['additionalAuthors'] as $authorData) {
			$this->addAuthor($authorData);
		}

		// Permit the subclass to handle any extra step 3 actions
		$this->_handleStep3($data);

		// Finish
		$this->waitForElementPresent('//span[text()=\'Finish Submission\']/..');
		$this->click('//span[text()=\'Finish Submission\']/..');
		$this->waitForText('css=div.pkp_controllers_modal_titleBar > h2', 'Confirm');
		$this->waitForElementPresent("//span[text()='OK']/..");
		$this->click("//span[text()='OK']/..");
		$this->waitForText('css=#ui-tabs-4 > h2', 'Submission complete');
		$this->waitJQuery();
	}

	/**
	 * Upload a file via the file wizard.
	 * @param $fileTitle string
	 * @param $file string (Null to use dummy file)
	 * @param $selectGenre booleani
	 * @param $openWizardLinkId string Optionally pass the
	 * link id to open the wizard modal.
	 */
	protected function uploadWizardFile($fileTitle, $file = null, $selectGenre = true, $openWizardLinkId = null) {
		if ($openWizardLinkId) {
			$this->waitForElementPresent($openWizardLinkLocator = 'css=[id^=' . $openWizardLinkId  . ']');
			$this->click($openWizardLinkLocator);
		}
		if (!$file) $file = getenv('DUMMYFILE');
		$this->waitForElementPresent('id=plupload');
		if ($selectGenre) {
			$this->waitForElementPresent('id=genreId');
			$this->select('id=genreId', 'label=' . $this->_getSubmissionElementName());
		}
		$this->uploadFile($file);
		$this->click('id=continueButton');
		$this->waitForElementPresent('css=[id^=name-]');
		$this->type('css=[id^=name-]', $fileTitle);
		$this->runScript('$(\'#metadataForm\').valid();');
		$this->click('//span[text()=\'Continue\']/..');
		$this->waitJQuery();
		$this->waitForElementPresent('//span[text()=\'Complete\']/..');
		$this->click('//span[text()=\'Complete\']/..');
		$this->waitJQuery();
	}
	/**
	 * Add an author to the submission's author list.
	 * @param $data array
	 */
	protected function addAuthor($data) {
		// Check that the required parameters are provided
		foreach (array(
			'firstName', 'lastName', 'email', 'country',
		) as $paramName) {
			$this->assertTrue(isset($data[$paramName]));
		}

		$data = array_merge(array(
			'role' => 'Author',
		), $data);

		$this->click('css=[id^=component-grid-users-author-authorgrid-addAuthor-button-]');
		$this->waitForElementPresent('css=[id^=firstName-]');
		$this->type('css=[id^=firstName-]', $data['firstName']);
		$this->type('css=[id^=lastName-]', $data['lastName']);
		$this->select('id=country', $data['country']);
		$this->type('css=[id^=email-]', $data['email']);
		if (isset($data['affiliation'])) $this->type('css=[id^=affiliation-]', $data['affiliation']);
		$this->click('//label[text()=\'' . $this->escapeJS($data['role']) . '\']');
		$this->click('//span[text()=\'Save\']/..');
		$this->waitForElementNotPresent('css=.ui-widget-overlay');
		$this->waitJQuery();
	}

	/**
	 * Log in as an Editor and find the specified submission.
	 * @param $username string
	 * @param $password string (null to presume twice-username)
	 * @param $title string
	 * @return int The submission id.
	 */
	protected function findSubmissionAsEditor($username, $password = null, $title) {
		if ($password === null) $password = $username . $username;
		$this->logIn($username, $password);
		$this->waitForElementPresent('xpath=(//a[contains(text(),\'Submissions\')])[2]');
		$this->click('xpath=(//a[contains(text(),\'Submissions\')])[2]');
		$xpath = $this->getEscapedXPathForLink($title);
		$this->waitForElementPresent($xpath);
		$linkId = $this->getAttribute($xpath . '/@id');
		$explodedId = explode('-', $linkId);
		$submissionId = $explodedId[1];
		$this->click($xpath);
		return $submissionId;
	}

	/**
	 * Record an editorial decision
	 * @param $decision string
	 */
	protected function recordEditorialDecision($decision) {
		$this->waitForElementPresent('//span[text()=\'' . $this->escapeJS($decision) . '\']/..');
		$this->click('//span[text()=\'' . $this->escapeJS($decision) . '\']/..');
		$this->waitForElementPresent('//span[text()=\'Record Editorial Decision\']/..');
		$this->click('//span[text()=\'Record Editorial Decision\']/..');
		$this->waitForElementNotPresent('css=.ui-widget-overlay');
	}

	/**
	 * Assign a participant.
	 * @param $role string
	 * @param $name string
	 * @param $templateValue string
	 */
	protected function assignParticipant($role, $name, $templateValue = null) {
		$this->waitForElementPresent('css=[id^=component-grid-users-stageparticipant-stageparticipantgrid-requestAccount-button-]');
		$this->click('css=[id^=component-grid-users-stageparticipant-stageparticipantgrid-requestAccount-button-]');
		$this->waitJQuery();
		$this->select('id=userGroupId', 'label=' . $this->escapeJS($role));
		$this->waitForElementPresent('//select[@name=\'userId\']//option[text()=\'' . $this->escapeJS($name) . '\']');
		$this->select('id=userId', 'label=' . $this->escapeJS($name));

		if ($templateValue) {
			$this->select('id=template', 'value=' . $templateValue);
			$this->waitJQuery();
		}

		$this->click('//span[text()=\'OK\']/..');
		$this->waitForGeneralNotification('User added as a stage participant.');
		$this->waitJQuery();
	}

	/**
	 * Send message to an stage participant.
	 * @param $name string
	 * @param $templateValue string
	 * @param $message string
	 */
	protected function notifyParticipant($name, $templateValue = null, $message = null) {
		$this->waitForElementPresent('css=[id^=component-grid-users-stageparticipant-stageparticipantgrid-]');
		$this->click('//span[@class=\'gridCellContainer\']/span[contains(text(), \'' . $name . '\')]
				/../../../../../following-sibling::tr//a[@class=\'sprite notify pkp_controllers_linkAction\']');
		$this->waitJQuery();
		if ($templateValue) {
			$this->select('id=template', 'value=' . $templateValue);
			$this->waitJQuery();
		}
		if ($message) {
			$this->type('css=[id^=message-]', $message);
		}

		$this->submitAjaxForm('notifyForm');
		$this->waitForGeneralNotification('Notification sent to users.');
		$this->waitJQuery();
	}

	/**
	 * Assign a reviewer.
	 * @param $username string
	 * @param $name string
	 */
	function assignReviewer($username, $name) {
		$this->waitForElementPresent('css=[id^=component-grid-users-reviewer-reviewergrid-addReviewer-button-]');
		$this->click('css=[id^=component-grid-users-reviewer-reviewergrid-addReviewer-button-]');
		$this->waitForElementPresent('css=[id^=reviewerId_input-]');
		$this->type('css=[id^=reviewerId_input-]', $username);
		$this->typeKeys('css=[id^=reviewerId_input-]', $username);
		$this->waitForElementPresent('//a[text()=\'' . $this->escapeJS($name) . '\']');
		$this->mouseOver('//a[text()=\'' . $this->escapeJS($name) . '\']');
		$this->click('//a[text()=\'' . $this->escapeJS($name) . '\']');
		$this->click('//span[text()=\'Add Reviewer\']/..');
		$this->waitForElementNotPresent('css=.ui-widget-overlay');
	}

	/**
	 * Log in as a reviewer and perform a review.
	 * @param $username string
	 * @param $password string (or null to presume twice-username)
	 * @param $title string
	 * @param $recommendation string Optional recommendation label
	 * @param $comments string optional Optional comment text
	 */
	function performReview($username, $password, $title, $recommendation = null, $comments = 'Here are my review comments.', $reviewFilename = null, $uploadFile = false) {
		if ($password===null) $password = $username . $username;
		$this->logIn($username, $password);
		$this->waitForElementPresent('//div[@id=\'dashboardTabs\']//a[text()=\'Submissions\']');
		$this->click('//div[@id=\'dashboardTabs\']//a[text()=\'Submissions\']');
		$xpath = $this->getEscapedXPathForLink($title); 
		$this->waitForElementPresent($xpath);
		$this->click($xpath);

		// Step 1.
		$this->waitForElementPresent('//span[text()=\'Accept Review, Continue to Step #2\']/..');
		$this->click('//span[text()=\'Accept Review, Continue to Step #2\']/..');

		// Step 2.	
		$this->waitForElementPresent('//span[text()=\'Continue to Step #3\']/..');
		$this->click('//span[text()=\'Continue to Step #3\']/..');

		// Step 3.
		if ($reviewFilename) {
			// Test downloading the review file.
			$this->downloadFile($reviewFilename);
		}

		$this->waitForElementPresent('css=[id^=comments-]');
		$this->type('css=[id^=comments-]', $comments);

		if ($recommendation !== null) {
			$this->select('id=recommendation', 'label=' . $this->escapeJS($recommendation));
		}

		if ($uploadFile) {
			$this->waitForElementPresent($uploadFileSelector = 'css=[id^=component-grid-files-attachment-reviewerreviewattachmentsgrid-addFile-button-]');
			$this->click($uploadFileSelector);
			$this->uploadWizardFile($reviewerFileTitle = 'Revised file', null, false);
			$this->waitForElementPresent($this->getEscapedXPathForLink($reviewerFileTitle)); // Confirm that the uploaded file link appears on the page. 
		}

		$this->waitForElementPresent('//span[text()=\'Submit Review\']/..');
		$this->click('//span[text()=\'Submit Review\']/..');
		$this->waitForElementPresent('//span[text()=\'OK\']/..');
		$this->click('//span[text()=\'OK\']/..');
		$this->waitForText('css=#ui-tabs-4 > h2', 'Review Submitted');
		$this->waitJQuery();
		$this->logOut();
	}

	protected function escapeJS($value) {
		return str_replace('\'', '\\\'', $value);
	}

	/**
	 * Clicks on the passed task text as the passed user.
	 * @param $user string
	 * @param $taskLinkText string
	 */
	protected function openTaskAsUser($user, $taskLinkText) {
		$this->logIn($user, $user . $user);
		// Click on the task.	
		$xpath = $this->getEscapedXPathForLink($taskLinkText);
		$this->waitForElementPresent($xpath);
		$this->clickAndWait($xpath);
		$this->waitJQuery();		
	}
}
?>
