{**
* templates/frontend/pages/userLogin.tpl
*
* Copyright (c) 2014-2017 Simon Fraser University
* Copyright (c) 2000-2017 John Willinsky
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
*
* User login form.
*
*}
{include file="frontend/components/header.tpl" pageTitle="user.login"}

<div class="page page_login">
    {include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login"}

    {* A login message may be displayed if the user was redireceted to the
    login page from another request. Examples include if login is required
    before dowloading a file. *}
    {if $loginMessage}
        <p>
            {translate key=$loginMessage}
        </p>
    {/if}

    <form class="cmp_form cmp_form login" id="login" method="post" action="{$loginUrl}">
        {csrf}

        {if $error}
            <div class="pkp_form_error">
                {translate key=$error reason=$reason}
            </div>
        {/if}

        <input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}" />

        <fieldset class="fields">
            <div class="username">
                    <label for="username">
                        {*					<span class="label">*}
                        {translate key="user.username"}
                        <span class="required required--asterisk">*</span>
                        <span class="pkp_screen_reader">
                            {translate key="common.required"}
                        </span>
                        {*					</span>*}
                        {*<input type="text" name="username" id="username" value="{$username|escape}" maxlength="32" required>*}
                    </label><br />
                    <span class="inp-fix">
                        <input type="text" name="username" id="username" value="{$username|escape}" maxlength="32" required class="inp-text">
                    </span>
            </div>
                    <br />
            <div class="password">
                    <label for="password">
                        {*					<span class="label">*}
                        {translate key="user.password"}
                        <span class="required required--asterisk">*</span>
                        <span class="pkp_screen_reader">
                            {translate key="common.required"}
                        </span>
                        {*	</span>
                        <input type="password" name="password" id="password" value="{$password|escape}" password="true" maxlength="32" required>
                        <a href="{url page="login" op="lostPassword"}">
                        {translate key="user.login.forgotPassword"}
                        </a>*}
                    </label><br />
                    <span class="inp-fix">
                        <input type="password" name="password" id="password" value="{$password|escape}" password="true" maxlength="32" required class="inp-text">
                    </span>
                    <br />
                    <a href="{url page="login" op="lostPassword"}">
                        {translate key="user.login.forgotPassword"}
                        </a>
            </div>
                        <br />
            <div class="remember checkbox">
                <label class="inp-item inp-item--checkbox">
                    <input type="checkbox" name="remember" id="remember" value="1" checked="$remember">
                    <span class="label">
                        {translate key="user.login.rememberUsernameAndPassword"}
                    </span>
                </label>
            </div>
                    <br />
            <div class="buttons">
                <button class="btn btn-primary btn-s" type="submit">
                    <span>{translate key="user.login"}</span>
                </button>
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
