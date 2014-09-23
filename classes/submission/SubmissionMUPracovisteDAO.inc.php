<?php

/**
 * @file classes/submission/SubmissionSubjectDAO.inc.php
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2000-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class SubmissionSubjectDAO
 * @ingroup submission
 * @see Submission
 *
 * @brief Operations for retrieving and modifying a submission's assigned subjects
 */

import('lib.pkp.classes.controlledVocab.ControlledVocabDAO');

define('CONTROLLED_VOCAB_SUBMISSION_MUPRACOVISTE', 'submissionMUPracoviste');

class SubmissionSubjectDAO extends ControlledVocabDAO {
	/**
	 * Constructor
	 */
	function submissionMUPracovisteDAO() {
		parent::ControlledVocabDAO();
	}

	/**
	 * Build/fetch and return a controlled vocabulary for subjects.
	 * @param $submissionId int
	 * @return ControlledVocab
	 */
	function build($submissionId) {
		// may return an array of ControlledVocabs
		return parent::build(CONTROLLED_VOCAB_SUBMISSION_MUPRACOVISTE, ASSOC_TYPE_SUBMISSION, $submissionId);
	}

	/**
	 * Get the list of localized additional fields to store.
	 * @return array
	 */
	function getLocaleFieldNames() {
		return array('submissionMUPracoviste');
	}

	/**
	 * Get Subjects for a submission.
	 * @param $submissionId int
	 * @param $locales array
	 * @return array
	 */
	function getMUPracoviste($submissionId, $locales) {
		$returner = array();
		$submissionMUPracovisteEntryDao = DAORegistry::getDAO('SubmissionMUPracovisteEntryDAO');
		foreach ($locales as $locale) {
			$returner[$locale] = array();
			$muPracoviste = $this->build($submissionId);
			$submissionMUPracoviste = $submissionMUPracovisteEntryDao->getByControlledVocabId($muPracoviste->getId());

			while ($muPrac = $submissionMUPracoviste->next()) {
				$muPrac = $muPrac->getMUPrac();
				if (array_key_exists($locale, $muPrac)) { // quiets PHP when there are no Subjects for a given locale
					$returner[$locale][] = $muPrac[$locale];
				}
			}
		}
		return $returner;
	}

	/**
	 * Get an array of all of the submission's MUPracoviste
	 * @return array
	 */
	function getAllUniqueMUPracoviste() {
		$subjects = array();

		$result = $this->retrieve(
			'SELECT DISTINCT setting_value FROM controlled_vocab_entry_settings WHERE setting_name = ?', CONTROLLED_VOCAB_SUBMISSION_MUPRACOVISTE
		);

		while (!$result->EOF) {
			$subjects[] = $result->fields[0];
			$result->MoveNext();
		}

		$result->Close();
		return $subjects;
	}

	/**
	 * Get an array of submissionIds that have a given subject
	 * @param $muPrac string
	 * @return array
	 */
	function getSubmissionIdsByMUPrac($muPrac) {
		$result = $this->retrieve(
			'SELECT assoc_id
			 FROM controlled_vocabs cv
			 LEFT JOIN controlled_vocab_entries cve ON cv.controlled_vocab_id = cve.controlled_vocab_id
			 INNER JOIN controlled_vocab_entry_settings cves ON cve.controlled_vocab_entry_id = cves.controlled_vocab_entry_id
			 WHERE cves.setting_name = ? AND cves.setting_value = ?',
			array(CONTROLLED_VOCAB_SUBMISSION_MUPRACOVISTE, $muPrac)
		);

		$returner = array();
		while (!$result->EOF) {
			$row = $result->GetRowAssoc(false);
			$returner[] = $row['assoc_id'];
			$result->MoveNext();
		}
		$result->Close();
		return $returner;
	}

	/**
	 * Add an array of subjects
	 * @param $subjects array
	 * @param $submissionId int
	 * @param $deleteFirst boolean
	 * @return int
	 */
	function insertMUPracoviste($muPracoviste, $submissionId, $deleteFirst = true) {
		$muPracovisteDao = DAORegistry::getDAO('SubmissionMUPracovisteDAO');
		$submissionMUPracovisteEntryDao = DAORegistry::getDAO('SubmissionMUPracovisteEntryDAO');
		$currentMUPracoviste = $this->build($submissionId);

		if ($deleteFirst) {
			$existingEntries = $muPracovisteDao->enumerate($currentMUPracoviste->getId(), CONTROLLED_VOCAB_SUBMISSION_MUPRACOVISTE);

			foreach ($existingEntries as $id => $entry) {
				$entry = trim($entry);
				$submissionMUPracovisteEntryDao->deleteObjectById($id);
			}
		}
		if (is_array($muPracoviste)) { // localized, array of arrays

			foreach ($muPracoviste as $locale => $list) {
				if (is_array($list)) {
					$list = array_unique($list); // Remove any duplicate Subjects
					$i = 1;
					foreach ($list as $muPrac) {
						$muPracEntry = $submissionMUPracovisteEntryDao->newDataObject();
						$muPracEntry->setControlledVocabId($currentMUPracoviste->getID());
						$muPracEntry->setSubject(urldecode($muPrac), $locale);
						$muPracEntry->setSequence($i);
						$i++;
						$submissionMUPracovisteEntryDao->insertObject($muPracEntry);
					}
				}
			}
		}
	}
}

?>
