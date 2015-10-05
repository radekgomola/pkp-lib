<?php

/**
 * @defgroup identity Identity
 * Implements an abstract identity underlying e.g. User and Author records.
 */

/**
 * @file classes/identity/Identity.inc.php
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2000-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class Identity
 * @ingroup identity
 *
 * @brief Basic class providing common functionality for users and authors in the system.
 */

class Identity extends DataObject {
	/**
	 * Constructor
	 */
	function Identity() {
		parent::DataObject();
	}

	/**
	 * Get the identity's complete name.
	 * Includes first name, middle name (if applicable), and last name.
	 * @param $lastFirst boolean False / default: Firstname Middle Lastname
	 * 	If true: Lastname, Firstname Middlename
	 * @return string
	 */
	function getFullName($lastFirst = false, $tituly = false) {
		$salutation = $this->getData('salutation');
		$firstName = $this->getData('firstName');
		$middleName = $this->getData('middleName');
		$lastName = $this->getData('lastName');
		$suffix = $this->getData('suffix');
                $titulyPred = $this->getData('tituly_pred');
                $titulyZa = $this->getData('tituly_za');
		if ($lastFirst) {
			return $lastName.", "  . $firstName . ($middleName != ''?" $middleName":'');
		} elseif ($tituly) {
                        return ($titulyPred != ''?"$titulyPred ":'') . "$firstName " . ($middleName != ''?"$middleName ":'') . $lastName . ($titulyZa != ''?", $titulyZa":'');
                }else {
			return ($salutation != ''?"$salutation ":'') . "$firstName " . ($middleName != ''?"$middleName ":'') . $lastName . ($suffix != ''?", $suffix":'');
		}
	}


	/**
	 * Get first name.
	 * @return string
	 */
	function getFirstName() {
		return $this->getData('firstName');
	}

	/**
	 * Set first name.
	 * @param $firstName string
	 */
	function setFirstName($firstName) {
		return $this->setData('firstName', $firstName);
	}


	/**
	 * Get middle name.
	 * @return string
	 */
	function getMiddleName() {
		return $this->getData('middleName');
	}

	/**
	 * Set middle name.
	 * @param $middleName string
	 */
	function setMiddleName($middleName) {
		return $this->setData('middleName', $middleName);
	}

	/**
	 * Get last name.
	 * @return string
	 */
	function getLastName() {
		return $this->getData('lastName');
	}

	/**
	 * Set last name.
	 * @param $lastName string
	 */
	function setLastName($lastName) {
		return $this->setData('lastName', $lastName);
	}

	/**
	 * Get initials.
	 * @return string
	 */
	function getInitials() {
		return $this->getData('initials');
	}

	/**
	 * Set initials.
	 * @param $initials string
	 */
	function setInitials($initials) {
		return $this->setData('initials', $initials);
	}
        
	/**
	 * Get user salutation.
	 * @return string
	 */
	function getSalutation() {
		return $this->getData('salutation');
	}

	/**
	 * Set user salutation.
	 * @param $salutation string
	 */
	function setSalutation($salutation) {
		return $this->setData('salutation', $salutation);
	}

	/**
	 * Get affiliation (position, institution, etc.).
	 * @param $locale string
	 * @return string
	 */
	function getAffiliation($locale) {
		return $this->getData('affiliation', $locale);
	}

	/**
	 * Set affiliation.
	 * @param $affiliation string
	 * @param $locale string
	 */
	function setAffiliation($affiliation, $locale) {
		return $this->setData('affiliation', $affiliation, $locale);
	}

	/**
	 * Get the localized affiliation for this author
	 */
	function getLocalizedAffiliation() {
		return $this->getLocalizedData('affiliation');
	}

	/**
	 * Get email address.
	 * @return string
	 */
	function getEmail() {
		return $this->getData('email');
	}

	/**
	 * Set email address.
	 * @param $email string
	 */
	function setEmail($email) {
		return $this->setData('email', $email);
	}

	/**
	 * Get name suffix.
	 * @return string
	 */
	function getSuffix() {
		return $this->getData('suffix');
	}

	/**
	 * Set suffix.
	 * @param $suffix string
	 */
	function setSuffix($suffix) {
		return $this->setData('suffix', $suffix);
	}
	/**
	 * Get country code
	 * @return string
	 */
	function getCountry() {
		return $this->getData('country');
	}

	/**
	 * Get localized country
	 * @return string
	 */
	function getCountryLocalized() {
		$countryDao = DAORegistry::getDAO('CountryDAO');
		$country = $this->getCountry();
		if ($country) {
			return $countryDao->getCountry($country);
		}
		return null;
	}

	/**
	 * Set country code.
	 * @param $country string
	 */
	function setCountry($country) {
		return $this->setData('country', $country);
	}

	/**
	 * Get URL.
	 * @return string
	 */
	function getUrl() {
		return $this->getData('url');
	}

	/**
	 * Set URL.
	 * @param $url string
	 */
	function setUrl($url) {
		return $this->setData('url', $url);
	}

	/**
	 * Get the localized biography for this author
	 */
	function getLocalizedBiography() {
		return $this->getLocalizedData('biography');
	}

	/**
	 * Get author biography.
	 * @param $locale string
	 * @return string
	 */
	function getBiography($locale) {
		return $this->getData('biography', $locale);
	}

	/**
	 * Set author biography.
	 * @param $biography string
	 * @param $locale string
	 */
	function setBiography($biography, $locale) {
		return $this->setData('biography', $biography, $locale);
	}
        
        /*******************************
         * MUNIPRESS DATA
         *******************************/
        
        /**
	 * Get UČO.
	 * @return int
	 */
	function getUCO() {
		return $this->getData('uco');
	}

	/**
	 * Set UČO.
	 * @param $uco int
	 */
	function setUCO($uco) {
		return $this->setData('uco', $uco);
	}
        
        /**
	 * Get číslo pracoviště MU.
	 * @return int
	 */
	function getMU() {
		return $this->getData('mu');
	}

	/**
	 * Set číslo pracoviště MU.
	 * @param $mu int
	 */
	function setMU($mu) {
		return $this->setData('mu', $mu);
	}
      
        /**
	 * Get tituly před jménem.
	 * @return string
	 */
	function getTitulyPred() {
		return $this->getData('tituly_pred');
	}

	/**
	 * Set tituly před jménem.
	 * @param $tituly_pred string
	 */
	function setTitulyPred($tituly_pred) {
		return $this->setData('tituly_pred', $tituly_pred);
	}
        
        /**
	 * Get tituly za jménem.
	 * @return string
	 */
	function getTitulyZa() {
		return $this->getData('tituly_za');
	}

	/**
	 * Set tituly za jménem.
	 * @param $tituly_za string
	 */
	function setTitulyZa($tituly_za) {
		return $this->setData('tituly_za', $tituly_za);
	}
        
        /**
	 * Get rodné číslo.
	 * @return string
	 */
	function getRodneCislo() {
		return $this->getData('rodne_cislo');
	}

	/**
	 * Set rodné číslo.
	 * @param $rodne_cislo string
	 */
	function setRodneCislo($rodne_cislo) {
		return $this->setData('rodne_cislo', $rodne_cislo);
	}

        /**
	 * Get poznámka.
	 * @return string
	 */
	function getPoznamka() {
		return $this->getData('poznamka');
	}

	/**
	 * Set poznámka.
	 * @param $poznamka string
	 */
	function setPoznamka($poznamka) {
		return $this->setData('poznamka', $poznamka);
	}
        
}

?>
