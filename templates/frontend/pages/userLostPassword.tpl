{**
* templates/frontend/pages/userLostPassword.tpl
*
* Copyright (c) 2014-2017 Simon Fraser University
* Copyright (c) 2000-2017 John Willinsky
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
*
* Password reset form.
*
*}
{include file="frontend/components/header.tpl" pageTitle="user.login.resetPassword"}

<div class="page page_lost_password">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login.resetPassword"}

    <p>{translate key="user.login.resetPasswordInstructions"}</p>

    <form class="cmp_form lost_password" id="lostPasswordForm" action="{url page="login" op="requestResetPassword"}" method="post">
        {csrf}
        {if $error}
            <div class="pkp_form_error">
                {translate key=$error}
            </div>
        {/if}

        <fieldset class="fields">
            <div class="email">
                <label>
                    {*					<span class="label">*}
                    {translate key="user.login.registeredEmail"}
                    <span class="required required--asterisk">*</span>
                    <span class="pkp_screen_reader">
                        {translate key="common.required"}
                    </span>
                    {*					</span>*}
                </label>
                <br />

                <span class="inp-fix">
                    <input type="text" name="email" id="email" value="{$email|escape}" required  class="inp-text">
                </span>
            </div><br />
            <div class="buttons">
                {*<button class="submit" type="submit">
                {translate key="user.login.resetPassword"}
                </button>*}
                <a  href="#" onclick="document.getElementById('lostPasswordForm').submit();
                        return false;" class="btn btn-primary btn-s">
                    <span>{translate key="user.login.resetPassword"}</span>
                </a>
                {if !$disableUserReg}
                    {url|assign:registerUrl page="user" op="register" source=$source}
                    <a href="{$registerUrl}" class="register">
                        {translate key="user.login.registerNewAccount"}
                    </a>
                {/if}
            </div>
            <br />
        </fieldset>

    </form>

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
