<?php

/**
 * @file plugins/importexport/native/filter/RepresentationNativeXmlFilter.inc.php
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2000-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class RepresentationNativeXmlFilter
 * @ingroup plugins_importexport_native
 *
 * @brief Base class that converts a representation to a Native XML document
 */

import('lib.pkp.plugins.importexport.native.filter.NativeExportFilter');

class RepresentationNativeXmlFilter extends NativeExportFilter {
	/**
	 * Constructor
	 * @param $filterGroup FilterGroup
	 */
	function RepresentationNativeXmlFilter($filterGroup) {
		$this->setDisplayName('Native XML representation export');
		parent::NativeExportFilter($filterGroup);
	}


	//
	// Implement template methods from PersistableFilter
	//
	/**
	 * @copydoc PersistableFilter::getClassName()
	 */
	function getClassName() {
		return 'lib.pkp.plugins.importexport.native.filter.RepresentationNativeXmlFilter';
	}


	//
	// Implement template methods from Filter
	//
	/**
	 * @see Filter::process()
	 * @param $representation Representation
	 * @return DOMDocument
	 */
	function &process(&$representation) {
		// Create the XML document
		$doc = new DOMDocument('1.0');
		$deployment = $this->getDeployment();
		$rootNode = $this->createRepresentationNode($doc, $representation);
		$doc->appendChild($rootNode);
		$rootNode->setAttributeNS('http://www.w3.org/2000/xmlns/', 'xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
		$rootNode->setAttribute('xsi:schemaLocation', $deployment->getNamespace() . ' ' . $deployment->getSchemaFilename());

		return $doc;
	}

	//
	// Representation conversion functions
	//
	/**
	 * Create and return a representation node.
	 * @param $doc DOMDocument
	 * @param $representation Representation
	 * @return DOMElement
	 */
	function createRepresentationNode($doc, $representation) {
		$deployment = $this->getDeployment();
		$context = $deployment->getContext();

		// Create the representation node
		$representationNode = $doc->createElementNS($deployment->getNamespace(), $deployment->getRepresentationNodeName());

		// Add metadata
		$this->createLocalizedNodes($doc, $representationNode, 'name', $representation->getName(null));
		$sequenceNode = $doc->createElementNS($deployment->getNamespace(), 'seq');
		$sequenceNode->appendChild($doc->createTextNode($representation->getSeq()));
		$representationNode->appendChild($sequenceNode);
                
                
                /****************
                 * Other data
                 ****************/
                
                $this->createOptionalNode($doc, $representationNode, 'width_mp', $representation->getWidth());
                $this->createOptionalNode($doc, $representationNode, 'widthUnitCode_mp', $representation->getWidthUnitCode());
                $this->createOptionalNode($doc, $representationNode, 'height_mp', $representation->getHeight());
                $this->createOptionalNode($doc, $representationNode, 'heightUnitCode_mp', $representation->getHeightUnitCode());
                $this->createOptionalNode($doc, $representationNode, 'thickness_mp', $representation->getThickness());
                $this->createOptionalNode($doc, $representationNode, 'thicknessUnitCode_mp', $representation->getThicknessUnitCode());
                $this->createOptionalNode($doc, $representationNode, 'weight_mp', $representation->getWeight());
                $this->createOptionalNode($doc, $representationNode, 'weightUnitCode_mp', $representation->getWeightUnitCode());
                $this->createOptionalNode($doc, $representationNode, 'file_size_mp', $representation->getFileSize());
                
                /****************
                 * MUNIPRESS
                 ****************/
                $this->createOptionalNode($doc, $representationNode, 'pocet_stran', $representation->getPocetStran());
                $this->createOptionalNode($doc, $representationNode, 'datum_vydani', $representation->getDatumVydani());
                $this->createOptionalNode($doc, $representationNode, 'poradi_vydani', $representation->getPoradiVydani());
                $this->createOptionalNode($doc, $representationNode, 'naklad', $representation->getNaklad());
                $this->createOptionalNode($doc, $representationNode, 'povVytiskyDosly', $representation->getPovVytiskyDosly());
                $this->createOptionalNode($doc, $representationNode, 'povVytiskyOdesly', $representation->getPovVytiskyOdesly());
                $this->createOptionalNode($doc, $representationNode, 'tiskarna', $representation->getTiskarna());
                $this->createLocalizedNodes($doc, $representationNode, 'biblio_citace', $representation->getBibliografickaCitace(null));
                $this->createLocalizedNodes($doc, $representationNode, 'url_stazeni', $representation->getUrlStazeni(null));
                $this->createLocalizedNodes($doc, $representationNode, 'calameo_hash', $representation->getCalameoHash(null));
                

		// Add files
//		foreach ($this->getFiles($representation) as $submissionFile) {
//			$fileRefNode = $doc->createElementNS($deployment->getNamespace(), 'submission_file_ref');
//			$fileRefNode->setAttribute('id', $submissionFile->getFileId());
//			$fileRefNode->setAttribute('revision', $submissionFile->getRevision());
//			$representationNode->appendChild($fileRefNode);
//		}
                
                return $representationNode;
	}


	//
	// Abstract methods to be implemented by subclasses
	//
	/**
	 * Get the submission files associated with this representation
	 * @param $representation Representation
	 * @return array
	 */
	function getFiles($representation) {
		assert(false); // To be overridden by subclasses
	}
}

?>
