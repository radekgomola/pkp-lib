<?php

/**
 * @file plugins/importexport/native/filter/NativeXmlRepresentationFilter.inc.php
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2000-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class NativeXmlRepresentationFilter
 * @ingroup plugins_importexport_native
 *
 * @brief Base class that converts a Native XML document to a set of authors
 */

import('lib.pkp.plugins.importexport.native.filter.NativeImportFilter');

class NativeXmlRepresentationFilter extends NativeImportFilter {
	/**
	 * Constructor
	 * @param $filterGroup FilterGroup
	 */
	function NativeXmlRepresentationFilter($filterGroup) {
		$this->setDisplayName('Native XML representation import');
		parent::NativeImportFilter($filterGroup);
	}

	//
	// Implement template methods from PersistableFilter
	//
	/**
	 * @copydoc PersistableFilter::getClassName()
	 */
	function getClassName() {
		return 'lib.pkp.plugins.importexport.native.filter.NativeXmlRepresentationFilter';
	}


	/**
	 * Handle a submission element
	 * @param $node DOMElement
	 * @return array Array of Representation objects
	 */
	function handleElement($node) {
		$deployment = $this->getDeployment();
		$context = $deployment->getContext();
		$submission = $deployment->getSubmission();
		assert(is_a($submission, 'Submission'));

		// Create the data object
		$representationDao  = Application::getRepresentationDAO();
		$representation = $representationDao->newDataObject();
		$representation->setSubmissionId($submission->getId());
                
                

		// Handle metadata in subelements.  Look for the 'name' and 'seq' elements.
		// All other elements are handled by subclasses.
		for ($n = $node->firstChild; $n !== null; $n=$n->nextSibling) if (is_a($n, 'DOMElement')) switch($n->tagName) {
                        //Other data
                        case 'width_mp': $representation->setWidth($n->textContent); break;
                        case 'widthUnitCode_mp': $representation->setWidthUnitCode($n->textContent); break;
                        case 'height_mp': $representation->setHeight($n->textContent); break;
                        case 'heightUnitCode_mp': $representation->setHeightUnitCode($n->textContent); break;
                        case 'thickness_mp': $representation->setThickness($n->textContent); break;
                        case 'thicknessUnitCode_mp': $representation->setThicknessUnitCode($n->textContent); break;
                        case 'weight_mp': $representation->setWeight($n->textContent); break;
                        case 'weightUnitCode_mp': $representation->setWeightUnitCode($n->textContent); break;
                        case 'file_size_mp': $representation->setFileSize($n->textContent); break;
                    
                        //MUNIPRESS
                        case 'pocet_stran': $representation->setPocetStran($n->textContent); break;
                        case 'datum_vydani': $representation->setDatumVydani($n->textContent); break;
                        case 'poradi_vydani': $representation->setPoradiVydani($n->textContent); break;
                        case 'naklad': $representation->setNaklad($n->textContent); break;
                        case 'tiskarna': $representation->setTiskarna($n->textContent); break;
                        case 'povVytiskyDosly': $representation->setPovVytiskyDosly($n->textContent); break;
                        case 'povVytiskyOdesly': $representation->setPovVytiskyOdesly($n->textContent); break;
                        case 'biblio_citace': $representation->setBibliografickaCitace($n->textContent, $n->getAttribute('locale')); break;
                        case 'url_stazeni': $representation->setUrlStazeni($n->textContent, $n->getAttribute('locale')); break;
                        case 'calameo_hash': $representation->setCalameoHash($n->textContent, $n->getAttribute('locale')); break;
                        
                    
			case 'name': $representation->setName($n->textContent, $n->getAttribute('locale')); break;
			case 'seq': $representation->setSeq($n->textContent); break;                 
                        
                        default:
				fatalError('Unknown element ' . $n->tagName);

		}

		return $representation; // database insert is handled by sub class.
	}
}

?>
