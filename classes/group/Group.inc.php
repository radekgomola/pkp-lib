<?php

/**
 * @defgroup group
 */

/**
 * @file classes/group/Group.inc.php
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class Group
 * @ingroup group
 * @see GroupDAO
 *
 * @brief Describes user groups.
 */


define('GROUP_CONTEXT_EDITORIAL_TEAM',	0x000001);
define('GROUP_CONTEXT_PEOPLE',		0x000002);

class Group extends DataObject {
	/**
	 * Constructor
	 */
	function Group() {
		parent::DataObject();
	}

	/**
	 * Get localized title of group.
	 */
	function getLocalizedTitle() {
		return $this->getLocalizedData('title');
	}

	function getGroupTitle() {
		if (Config::getVar('debug', 'deprecation_warnings')) trigger_error('Deprecated function.');
		return $this->getLocalizedTitle();
	}


	//
	// Get/set methods
	//
	/**
	 * Get title of group (primary locale)
	 * @param $locale string
	 * @return string
	 */
	function getTitle($locale) {
		return $this->getData('title', $locale);
	}

	/**
	 * Set title of group
	 * @param $title string
	 * @param $locale string
	 */
	function setTitle($title, $locale) {
		return $this->setData('title', $title, $locale);
	}

	/**
	 * Get context of group
	 * @return int
	 */
	function getContext() {
		return $this->getData('context');
	}

	/**
	 * Set context of group
	 * @param $context int
	 */
	function setContext($context) {
		return $this->setData('context',$context);
	}

	/**
	 * Get publish email flag
	 * @return int
	 */
	function getPublishEmail() {
		return $this->getData('publishEmail');
	}

	/**
	 * Set publish email flag
	 * @param $context int
	 */
	function setPublishEmail($publishEmail) {
		return $this->setData('publishEmail',$publishEmail);
	}

        /**
	 * Get publish email in members' list
	 * @return int
	 */
	function getPublishEmailList() {
		return $this->getData('publishEmailList');
	}

	/**
	 * Set publish email in members' list
	 * @param $context int
	 */
	function setPublishEmailList($publishEmailList) {
		return $this->setData('publishEmailList',$publishEmailList);
	}
        
         /**
	 * Get publish email in members' list
	 * @return int
	 */
	function getPublishUrlList() {
		return $this->getData('publishUrlList');
	}

	/**
	 * Set publish email in members' list
	 * @param $context int
	 */
	function setPublishUrlList($publishUrlList) {
		return $this->setData('publishUrlList',$publishUrlList);
	}
        
        /**
	 * Get medailon link
	 * @return int
	 */
	function getAllowMedailon() {
		return $this->getData('allowMedailon');
	}

	/**
	 * Set publish email in members' list
	 * @param $context int
	 */
	function setAllowMedailon($allowMedailon) {
		return $this->setData('allowMedailon',$allowMedailon);
	}
        
        /**
	 * Get name format
	 * @return int
	 */
	function getOpacnyTvarJmena() {
		return $this->getData('opacnyTvarJmena');
	}

	/**
	 * Set name format
	 * @param $context int
	 */
	function setOpacnyTvarJmena($opacnyTvarJmena) {
		return $this->setData('opacnyTvarJmena',$opacnyTvarJmena);
	}
        
         /**
	 * Get type of showing profile
	 * @return int
	 */
	function getFullProfile() {
		return $this->getData('fullProfile');
	}

	/**
	 * Set type of showing profile
	 * @param $context int
	 */
	function setFullProfile($fullProfile) {
		return $this->setData('fullProfile',$fullProfile);
	}
        
	/**
	 * Get flag indicating whether or not the group is displayed in "About"
	 * @return boolean
	 */
	function getAboutDisplayed() {
		return $this->getData('aboutDisplayed');
	}

	/**
	 * Set flag indicating whether or not the group is displayed in "About"
	 * @param $aboutDisplayed boolean
	 */
	function setAboutDisplayed($aboutDisplayed) {
		return $this->setData('aboutDisplayed',$aboutDisplayed);
	}

	/**
	 * Get ID of group. Deprecated in favour of getId.
	 * @return int
	 */
	function getGroupId() {
		if (Config::getVar('debug', 'deprecation_warnings')) trigger_error('Deprecated function.');
		return $this->getId();
	}

	/**
	 * Set ID of group. DEPRECATED in favour of setId.
	 * @param $groupId int
	 */
	function setGroupId($groupId) {
		if (Config::getVar('debug', 'deprecation_warnings')) trigger_error('Deprecated function.');
		return $this->setId($groupId);
	}

	/**
	 * Get assoc ID for this group.
	 * @return int
	 */
	function getAssocId() {
		return $this->getData('assocId');
	}

	/**
	 * Set assoc ID for this group.
	 * @param $assocId int
	 */
	function setAssocId($assocId) {
		return $this->setData('assocId', $assocId);
	}

	/**
	 * Get assoc type for this group.
	 * @return int
	 */
	function getAssocType() {
		return $this->getData('assocType');
	}

	/**
	 * Set assoc type for this group.
	 * @param $assocType int
	 */
	function setAssocType($assocType) {
		return $this->setData('assocType', $assocType);
	}

	/**
	 * Get sequence of group.
	 * @return float
	 */
	function getSequence() {
		return $this->getData('sequence');
	}

	/**
	 * Set sequence of group.
	 * @param $sequence float
	 */
	function setSequence($sequence) {
		return $this->setData('sequence', $sequence);
	}
        
        /**
	 * Get localized description of group.
	 */
	function getLocalizedGroupDescription() {
		return $this->getLocalizedData('groupDescription');
	}

	/**
	 * Get description of group (primary locale)
	 * @param $locale string
	 * @return string
	 */
	function getGroupDescription($locale) {
		return $this->getData('groupDescription', $locale);
	}

	/**
	 * Set description of group
	 * @param $groupDescription string
	 * @param $locale string
	 */
	function setGroupDescription($groupDescription, $locale) {
		return $this->setData('groupDescription', $groupDescription, $locale);
	}
        
        /**
	 * Get sequence of group.
	 * @return float
	 */
	function getGroupSetupTopDown() {
		return $this->getData('groupSetupTopDown');
	}

	/**
	 * Set sequence of group.
	 * @param $sequence float
	 */
	function setGroupSetupTopDown($groupSetupTopDown) {
		return $this->setData('groupSetupTopDown', $groupSetupTopDown);
	}
}

?>
