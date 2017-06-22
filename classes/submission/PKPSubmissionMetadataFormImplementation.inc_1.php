<?php

/**
 * @file classes/submission/SubmissionMetadataFormImplementation.inc.php
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class SubmissionMetadataFormImplementation
 * @ingroup submission
 *
 * @brief This can be used by other forms that want to
 * implement submission metadata data and form operations.
 */

class PKPSubmissionMetadataFormImplementation {

	/** @var Form Form that use this implementation */
	var $_parentForm;

	/**
	 * Constructor.
	 *
	 * @param $parentForm Form A form that can use this form.
	 */
	function PKPSubmissionMetadataFormImplementation($parentForm = null) {

		if (is_a($parentForm, 'Form')) {
			$this->_parentForm = $parentForm;
		} else {
			assert(false);
		}
	}

	/**
	 * Add checks to form.
	 * @param $submission Submission
	 */
	function addChecks($submission) {
		import('lib.pkp.classes.form.validation.FormValidatorLocale');
		import('lib.pkp.classes.form.validation.FormValidatorCustom');

		// Validation checks.
		$this->_parentForm->addCheck(new FormValidatorLocale($this->_parentForm, 'title', 'required', 'submission.submit.form.titleRequired'));
		$this->_parentForm->addCheck(new FormValidatorLocale($this->_parentForm, 'abstract', 'required', 'submission.submit.form.abstractRequired'));
		// Validates that at least one author has been added (note that authors are in grid, so Form does not
		// directly see the authors value (there is no "authors" input. Hence the $ignore parameter.
		$this->_parentForm->addCheck(new FormValidatorCustom(
			$this->_parentForm, 'authors', 'required', 'submission.submit.form.authorRequired',
			// The first parameter is ignored. This
			create_function('$ignore, $submission', 'return count($submission->getAuthors()) > 0;'),
			array($submission)
		));
	}

	/**
	 * Initialize form data from current submission.
	 * @param $submission Submission
	 */
	function initData($submission) {
		if (isset($submission)) {
			$formData = array(
				'title' => $submission->getTitle(null), // Localized
				'prefix' => $submission->getPrefix(null), // Localized
				'subtitle' => $submission->getSubtitle(null), // Localized
				'abstract' => $submission->getAbstract(null), // Localized
				'subjectClass' => $submission->getSubjectClass(null), // Localized
				'coverageGeo' => $submission->getCoverageGeo(null), // Localized
				'coverageChron' => $submission->getCoverageChron(null), // Localized
				'coverageSample' => $submission->getCoverageSample(null), // Localized
				'type' => $submission->getType(null), // Localized
				'source' =>$submission->getSource(null), // Localized
				'rights' => $submission->getRights(null), // Localized
                                'citations' => $submission->getCitations(null),
                                
                                /*MUNIPRESS*/
                                'a_kol' => $submission->getAKolektiv(),
                                'cena' => $submission->getCena(), 
                                'cena_ebook' => $submission->getCenaEbook(), 		
                                'urlOC' => $submission->getUrlOC(),
                                'urlOC_ebook' => $submission->getUrlOCEbook(),
                                'pocetStran' => $submission->getPocetStran(),
                                'cisloVydani' => $submission->getCisloVydani(),
//                                'licenceTypPrepinac' => $submission->getTypLicencePrepinac(),                         
//                                'licenceTyp' => $submission->getLicenceTyp(), 
//                                'licenceDrzitel' => $submission->getLicenceDrzitel(),
//                                'licenceExpirace' => $submission->getLicenceExpirace(), 
//                                'licenceVznik' => $submission->getLicenceVznik(),
//                                'licenceZverejnit' => $submission->getLicenceZverejnit(),
//                                'naklad' => $submission->getNaklad(),
//                                'honorarCelkem' => $submission->getHonorarCelkem(),
//                                'honorarVyplata' => $submission->getHonorarVyplata(),
//                                'povVytiskyDosly' => $submission->getPovVytiskyDosly(),
//                                'povVytiskyOdesly' => $submission->getPovVytiskyOdesly(),
//                                'tiskarna' => $submission->getTiskarna(),
//                                'poznamkaAdmin' => $submission->getPoznamkaAdmin(),                                
                                
                                'urlWeb' => $submission->getLocalizedUrlWeb(null), // Localized
                                'bibliografickaCitace' => $submission->getBibliografickaCitace(null), // Localized
                                'poznamka' => $submission->getPoznamka(null), // Localized
                                'referencereferenceMunipress' => $submission->getReferenceMunipress(null), // Localized
                                'typ_02_58' => $submission->getLocalizedTypPublikace(null), // Localized
                                
			); 
			foreach ($formData as $key => $data) {
				$this->_parentForm->setData($key, $data);
			}

			// get the supported locale keys
			$locales = array_keys($this->_parentForm->supportedLocales);

			// load the persisted metadata controlled vocabularies
			$submissionKeywordDao = DAORegistry::getDAO('SubmissionKeywordDAO');
                        $submissionLanguageDao = DAORegistry::getDAO('SubmissionLanguageDAO');
                        
                        /*MUNIPRESS*/
//                        $submissionSouvisejiciPublikaceDao = DAORegistry::getDAO('SubmissionSouvisejiciPublikaceDAO');
//                        $submissionMUPracovisteDao = DAORegistry::getDAO('SubmissionMUPracovisteDAO');
                        
			$submissionSubjectDao = DAORegistry::getDAO('SubmissionSubjectDAO');
			$submissionDisciplineDao = DAORegistry::getDAO('SubmissionDisciplineDAO');
			$submissionAgencyDao = DAORegistry::getDAO('SubmissionAgencyDAO');
			

			
			$this->_parentForm->setData('keywords', $submissionKeywordDao->getKeywords($submission->getId(), $locales));
                        $this->_parentForm->setData('languages', $submissionLanguageDao->getLanguages($submission->getId(), $locales));
                        
                        /*MUNIPRESS*/
//                        $this->_parentForm->setData('souvisejiciPublikace', $submissionSouvisejiciPublikaceDao->getSouvisejiciPublikace($submission->getId(), $locales));
//                        $this->_parentForm->setData('muPracoviste', $submissionMUPracovisteDao->getMUPracoviste($submission->getId(), $locales));
                        
                        
                        $this->_parentForm->setData('subjects', $submissionSubjectDao->getSubjects($submission->getId(), $locales));
			$this->_parentForm->setData('disciplines', $submissionDisciplineDao->getDisciplines($submission->getId(), $locales));
			$this->_parentForm->setData('agencies', $submissionAgencyDao->getAgencies($submission->getId(), $locales));
			

			// include all submission metadata fields for submissions
			$this->_parentForm->setData('submissionSettings', array('all' => true));
		}
	}

	/**
	 * Assign form data to user-submitted data.
	 */
	function readInputData() {
		// 'keywords' is a tagit catchall that contains an array of values for each keyword/locale combination on the form.
		$userVars = array('title', 'prefix', 'subtitle', 'abstract', 'coverageGeo', 
                                'coverageChron', 'coverageSample', 'type', 'subjectClass', 
                                'source', 'rights', 'keywords', 
                                'a_kol', 'cena', 'cena_ebook', 'urlOC', 'urlOC_ebook', 
                                'pocetStran', 'cisloVydani', 'licenceTypPrepinac', 'licenceTyp', 
                                'licenceDrzitel', 'licenceExpirace', 'licenceVznik', 
                                'licenceZverejnit', 'naklad', 'honorarCelkem', 
                                'honorarVyplata', 'povVytiskyDosly', 'povVytiskyOdesly', 
                                'tiskarna', 'poznamkaAdmin', 'typ_02_58', 'urlWeb',
                                'bibliografickaCitace', 'poznamka', 'referenceMunipress',
                                'languages', 'souvisejiciPublikace', 'muPracoviste');
		$this->_parentForm->readUserVars($userVars);
	}

	/**
	 * Get the names of fields for which data should be localized
	 * @return array
	 */
	function getLocaleFieldNames() {
		return array('title', 'prefix', 'subtitle', 'abstract', 'coverageGeo', 'coverageChron', 'coverageSample', 'type', 'subjectClass', 'source', 'rights', 'bibliografickaCitace', 'poznamka', 'referenceMunipress', 'typ_02_58', 'urlWeb');
	}

	/**
	 * Save changes to submission.
	 * @param $submission Submission
	 * @param $request PKPRequest
	 * @return Submission
	 */
	function execute($submission, $request) {
		$submissionDao = Application::getSubmissionDAO();

		// Update submission
		$submission->setTitle($this->_parentForm->getData('title'), null); // Localized
		$submission->setPrefix($this->_parentForm->getData('prefix'), null); // Localized
		$submission->setSubtitle($this->_parentForm->getData('subtitle'), null); // Localized
		$submission->setAbstract($this->_parentForm->getData('abstract'), null); // Localized
		$submission->setCoverageGeo($this->_parentForm->getData('coverageGeo'), null); // Localized
		$submission->setCoverageChron($this->_parentForm->getData('coverageChron'), null); // Localized
		$submission->setCoverageSample($this->_parentForm->getData('coverageSample'), null); // Localized
		$submission->setType($this->_parentForm->getData('type'), null); // Localized
		$submission->setSubjectClass($this->_parentForm->getData('subjectClass'), null); // Localized
		$submission->setRights($this->_parentForm->getData('rights'), null); // Localized
		$submission->setSource($this->_parentForm->getData('source'), null); // Localized
                
                /*MUNIPRESS*/
                $submission->setAKolektiv($this->_parentForm->getData('a_kol'));
                $submission->setCena($this->_parentForm->getData('cena'));                
                $submission->setCenaEbook($this->_parentForm->getData('cena_ebook'));
                $submission->setUrlOC($this->_parentForm->getData('urlOC'));
                $submission->setUrlOCEbook($this->_parentForm->getData('urlOC_ebook'));
                $submission->setPocetStran($this->_parentForm->getData('pocetStran')); 
                $submission->setCisloVydani($this->_parentForm->getData('cisloVydani'));
//                $submission->setTypLicencePrepinac($this->_parentForm->getData('licenceTypPrepinac'));
//                $submission->setLicenceTyp($this->_parentForm->getData('licenceTyp'));
//                $submission->setLicenceDrzitel($this->_parentForm->getData('licenceDrzitel'));                
//                $submission->setLicenceExpirace($this->_parentForm->getData('licenceExpirace'));
//                $submission->setLicenceVznik($this->_parentForm->getData('licenceVznik'));
//                $submission->setLicenceZverejnit($this->_parentForm->getData('licenceZverejnit'));
//                $submission->setNaklad($this->_parentForm->getData('naklad')); 
//                $submission->setHonorarCelkem($this->_parentForm->getData('honorarCelkem'));
//                $submission->setHonorarVyplata($this->_parentForm->getData('honorarVyplata'));
//                $submission->setPovVytiskyDosly($this->_parentForm->getData('povVytiskyDosly'));
//                $submission->setPovVytiskyOdesly($this->_parentForm->getData('povVytiskyOdesly')); 
//                $submission->setTiskarna($this->_parentForm->getData('tiskarna'));
//                $submission->setPoznamkaAdmin($this->_parentForm->getData('poznamkaAdmin'));                
//                
//                $submission->setTypPublikace($this->_parentForm->getData('typ_02_58'), null); // Localized
//                $submission->setUrlWeb($this->_parentForm->getData('urlWeb'), null); // Localized
//                $submission->setBibliografickaCitace($this->_parentForm->getData('bibliografickaCitace'), null); // Localized
//                $submission->setPoznamka($this->_parentForm->getData('poznamka'), null); // Localized
//                $submission->setReferenceMunipress($this->_parentForm->getData('referenceMunipress'), null); // Localized

                // Save the submission
		$submissionDao->updateObject($submission);

		// get the supported locale keys
		$locales = array_keys($this->_parentForm->supportedLocales);

		// persist the metadata/keyword fields.
		$submissionKeywordDao = DAORegistry::getDAO('SubmissionKeywordDAO');
                $submissionLanguageDao = DAORegistry::getDAO('SubmissionLanguageDAO');
                
                /*MUNIPRESS*/
//                $submissionSouvisejiciPublikaceDao = DAORegistry::getDAO('SubmissionSouvisejiciPublikaceDAO');
//                $submissionMUPracovisteDao = DAORegistry::getDAO('SubmissionMUPracovisteDAO');
                
		$submissionSubjectDao = DAORegistry::getDAO('SubmissionSubjectDAO');
		$submissionDisciplineDao = DAORegistry::getDAO('SubmissionDisciplineDAO');
		$submissionAgencyDao = DAORegistry::getDAO('SubmissionAgencyDAO');

		$keywords = array();
                $languages = array();
                
                /*MUNIPRESS*/
//                $souvisejiciPublikace = array();
//                $muPracoviste = array();
                
		$agencies = array();
		$disciplines = array();
		$subjects = array();

		$tagitKeywords = $this->_parentForm->getData('keywords');

		if (is_array($tagitKeywords)) {
			foreach ($locales as $locale) {
				$keywords[$locale] = array_key_exists($locale . '-keyword', $tagitKeywords) ? $tagitKeywords[$locale . '-keyword'] : array();
                                $languages[$locale] = array_key_exists($locale . '-languages', $tagitKeywords) ? $tagitKeywords[$locale . '-languages'] : array();
                                /*MUNIPRESS*/
//                                $souvisejiciPublikace[$locale] = array_key_exists($locale . '-souvisejiciPublikace', $tagitKeywords) ? $tagitKeywords[$locale . '-souvisejiciPublikace'] : array();
//                                $muPracoviste[$locale] = array_key_exists($locale . '-muPracoviste', $tagitKeywords) ? $tagitKeywords[$locale . '-muPracoviste'] : array();
                                
                                
				$agencies[$locale] = array_key_exists($locale . '-agencies', $tagitKeywords) ? $tagitKeywords[$locale . '-agencies'] : array();
				$disciplines[$locale] = array_key_exists($locale . '-disciplines', $tagitKeywords) ? $tagitKeywords[$locale . '-disciplines'] : array();
				
				$subjects[$locale] = array_key_exists($locale . '-subjects', $tagitKeywords) ?$tagitKeywords[$locale . '-subjects'] : array();
			}
		}

		// persist the controlled vocabs
		$submissionKeywordDao->insertKeywords($keywords, $submission->getId());
                $submissionLanguageDao->insertLanguages($languages, $submission->getId());
                
                /*MUNIPRESS*/
//                $submissionSouvisejiciPublikaceDao->insertSouvisejiciPublikace($keywords, $submission->getId());
//                $submissionMUPracovisteDao->insertMUPracoviste($languages, $submission->getId());
                
		$submissionAgencyDao->insertAgencies($agencies, $submission->getId());
		$submissionDisciplineDao->insertDisciplines($disciplines, $submission->getId());
		$submissionSubjectDao->insertSubjects($subjects, $submission->getId());

		// Resequence the authors (this ensures a primary contact).
		$authorDao = DAORegistry::getDAO('AuthorDAO');
		$authorDao->resequenceAuthors($submission->getId());

		// Only log modifications on completed submissions
		if ($submission->getSubmissionProgress() == 0) {
			// Log the metadata modification event.
			import('lib.pkp.classes.log.SubmissionLog');
			import('classes.log.SubmissionEventLogEntry');
			SubmissionLog::logEvent($request, $submission, SUBMISSION_LOG_METADATA_UPDATE, 'submission.event.general.metadataUpdated');
		}
	}
}

?>
