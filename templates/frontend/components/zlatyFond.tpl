{**
* templates/frontend/components/registrationForm.tpl
*
* Copyright (c) 2014-2017 Simon Fraser University
* Copyright (c) 2003-2017 John Willinsky
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
*
* @brief Display the basic registration form fields
*
* @uses $locale string Locale key to use in the affiliate field
* @uses $firstName string First name input entry if available
* @uses $middleName string Middle name input entry if available
* @uses $lastName string Last name input entry if available
* @uses $countries array List of country options
* @uses $country string The selected country if available
* @uses $email string Email input entry if available
* @uses $username string Username input entry if available
*}
<hr />
<fieldset class="zlatyFond">
    <legend>
        <h3>
            {translate key="registration.zlatyFond"}
        </h3>
        <p>
            {translate key="registration.zlatyFond.description"}
        </p>
    </legend>
    <div class="zlatyFond gdpr">
        <br />
        <p>
            {translate key="registration.zlatyFond.prohlaseni"}
            {translate|assign:"zlatyFondText" key="registration.zlatyFond.prohlaseni"}
        </p>
    </div>
    <br />
    <fieldset class="consent">
        {* Require the user to agree to the terms of the privacy policy *}
        <div class="fields">
            <div class="optin optin-privacy">
                <label class="inp-item inp-item--checkbox">
                    <input type="checkbox" name="zlatyFond" value="1"{if $zlatyFond} checked="checked"{/if}>
                    <span class="label">{translate key="registration.zlatyFond.checkbox"}</span>
                </label>
            </div>
        </div>
        <input type="hidden" name="zlatyFondText" value="{$zlatyFondText|strip_tags|escape}">
    </fieldset>
</fieldset>
