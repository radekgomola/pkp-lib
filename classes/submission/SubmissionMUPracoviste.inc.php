<?php

/**
 * @file classes/submission/SubmissionMUPracoviste.inc.php
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2000-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class SubmissionMUPracoviste
 * @ingroup submission
 * @see SubmissionMUPreacovisteEntryDAO
 *
 * @brief Basic class describing a submission MU Pracoviste
 */

import('lib.pkp.classes.controlledVocab.ControlledVocabEntry');

class SubmissionMUPracoviste extends ControlledVocabEntry {
	//
	// Get/set methods
	//

	/**
	 * Get MUPrac
	 * @return string
	 */
	function getMUPrac() {
		return $this->getData('submissionMUPracoviste');
	}

	/**
	 * Set the subject text
	 * @param $muPrac string
	 * @param locale string
	 */
	function setMUPrac($muPrac, $locale) {
		$this->setData('submissionMUPracoviste', $muPrac, $locale);
	}

	function getLocaleMetadataFieldNames() {
		return array('submissionMUPracoviste');
	}
}
?>
