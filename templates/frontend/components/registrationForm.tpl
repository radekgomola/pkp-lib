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
<fieldset class="identity">
    <legend>
        <h3>
        {if $initCode =="munipomaha"}
            {translate key="navigation.munipomaha"}
        {else}
            {translate key="user.profile"}
        {/if}
        </h3>
    </legend>
    <div class="fields">
        <div class="first_name">
            <label for="firstName">
                {*				<span class="label">*}
                {translate key="user.firstName"}
                <span class="required required--asterisk">*</span>
                <span class="pkp_screen_reader">
                    {translate key="common.required"}
                </span>
                {*				</span>*}
            </label>
            <br />
            <span class="inp-fix">
                <input type="text" name="firstName" id="firstName" value="{$firstName|escape}" maxlength="40" required class="inp-text">
            </span>
        </div>
        <br />
        <div class="middle_name">
            <label for="middleName">
                {*                <span class="label">*}
                {translate key="user.middleName"}
                {*                </span>                *}
            </label>
            <br />
            <span class="inp-fix">
                <input type="text" name="middleName" value="{$middleName|escape}" maxlength="40" class="inp-text">
            </span>
        </div>
        <br />
        <div class="last_name">
            <label for="lastName">
                {*                <span class="label">*}
                {translate key="user.lastName"}
                <span class="required required--asterisk">*</span>
                <span class="pkp_screen_reader">
                    {translate key="common.required"}
                </span>
                {*                </span>*}

            </label>
            <br />
            <span class="inp-fix">
                <input type="text" name="lastName" id="lastName" value="{$lastName|escape}" maxlength="40" required class="inp-text">
            </span>
        </div>
        <br />
        <div class="affiliation">
            <label for="affiliation">
                {*                <span class="label">*}
                {translate key="user.affiliation"}
                <span class="required required--asterisk">*</span>
                <span class="pkp_screen_reader">
                    {translate key="common.required"}
                </span>
                {*                </span>*}
            </label>
            <br />
            <span class="inp-fix">
                {if $initCode == "munipomaha"}
                       <input type="text" name="affiliation[{$primaryLocale|escape}]" id="affiliation" value="{$initCode|escape}" required class="inp-text"> 
                {else}
                <input type="text" name="affiliation[{$primaryLocale|escape}]" id="affiliation" value="{$affiliation.$primaryLocale|escape}" required class="inp-text">
                {/if}
            </span>
        </div>
        <br />
        <div class="country">
            <label for="country">
                {*                <span class="label">*}
                {translate key="common.country"}
                <span class="required required--asterisk">*</span>
                <span class="pkp_screen_reader">
                    {translate key="common.required"}
                </span>
                {*                </span>*}
            </label><br />
            <span class="inp-fix inp-fix--select">
                <select name="country" id="country" required class="inp-select">
                    <option>{translate key="common.vyberte"}</option>
                    {html_options options=$countries selected=$country}
                </select>
            </span>
        </div>
    </div>
    <br />
</fieldset>

<fieldset class="login">
    <legend>
        <h3>
        {translate key="user.login"}
        </h3>
    </legend>
    <div class="fields">
        <div class="email">
            <label for="email">
                {*                <span class="label">*}
                {translate key="user.email"}
                <span class="required required--asterisk">*</span>
                <span class="pkp_screen_reader">
                    {translate key="common.required"}
                </span>
                {*                </span>*}

            </label>
            <br />
            <span class="inp-fix">
                <input type="text" name="email" id="email" value="{$email|escape}" maxlength="90" required class="inp-text">
            </span>
        </div>
        <br />
        <div class="username">
            <label for="username">
                {*                <span class="label">*}
                {translate key="user.username"}
                <span class="required required--asterisk">*</span>
                <span class="pkp_screen_reader">
                    {translate key="common.required"}
                </span>
                {*                </span>*}

            </label>
            <br />
            <span class="inp-fix">
                <input type="text" name="username" id="username" value="{$username|escape}" maxlength="32" required class="inp-text">
            </span>
        </div>
            <br/>
        <div class="password">
            <label>
                {*                <span class="label">*}
                {translate key="user.password"}
                <span class="required required--asterisk">*</span>
                <span class="pkp_screen_reader">
                    {translate key="common.required"}
                </span>
                {*                </span>*}

            </label>
            <br />
            <span class="inp-fix">
                <input type="password" name="password" id="password" password="true" maxlength="32" required class="inp-text">
            </span>
        </div>
        <br />
        <div class="password">
            <label>
                {*                <span class="label">*}
                {translate key="user.repeatPassword"}
                <span class="required required--asterisk">*</span>
                <span class="pkp_screen_reader">
                    {translate key="common.required"}
                </span>
                {*                </span>*}

            </label>
            <br />
            <span class="inp-fix">
                <input type="password" name="password2" id="password2" password="true" maxlength="32" required class="inp-text">
            </span>
        </div>
        <br />
    </div>
</fieldset>
