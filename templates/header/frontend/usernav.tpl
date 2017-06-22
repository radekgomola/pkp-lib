{**
 * templates/header/frontend/usernav.tpl
 *
 * Copyright (c) 2014-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site-Wide Navigation Bar
 *}
<script type="text/javascript">
	// Attach the JS file tab handler.
	$(function() {ldelim}
		$('#navigationUser').pkpHandler(
				'$.pkp.controllers.MenuHandler');
	{rdelim});
 </script>
<ul id="navigationUser" class="pkp_nav_list userNavFront header__userNav"  role="navigation" aria-label="{translate|escape key="common.navigation.user"}">
	{if $isUserLoggedIn}
		<li class="header__menu__secondary__item">
			{include file="controllers/page/tasks.tpl"}
		</li>
		<li class="header__menu__secondary__item profile has_submenu">
			<a href="{url router=$smarty.const.ROUTE_PAGE page="submissions"}">{$loggedInUsername|escape}</a>
			<ul >
				{if array_intersect(array(ROLE_ID_MANAGER, ROLE_ID_ASSISTANT, ROLE_ID_REVIEWER, ROLE_ID_AUTHOR), $userRoles)}
					<li class="header__menu__secondary__item">
						<a href="{url router=$smarty.const.ROUTE_PAGE page="submissions"}">
							{translate key="navigation.submissions"}
						</a>
					</li>
				{/if}
				<li class="header__menu__secondary__item">
					<a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="profile"}">
						{translate key="common.viewProfile"}
					</a>
				</li>
				{if array_intersect(array(ROLE_ID_SITE_ADMIN), $userRoles)}
				<li class="header__menu__secondary__item">
					<a href="{if $multipleContexts}{url router=$smarty.const.ROUTE_PAGE context="index" page="admin" op="index"}{else}{url router=$smarty.const.ROUTE_PAGE page="admin" op="index"}{/if}">
						{translate key="navigation.admin"}
					</a>
				</li>
				{/if}
				<li class="header__menu__secondary__item">
					<a href="{url router=$smarty.const.ROUTE_PAGE page="login" op="signOut"}">
						{translate key="user.logOut"}
					</a>
				</li>
				{if $isUserLoggedInAs}
					<li class="header__menu__secondary__item">
						<a href="{url router=$smarty.const.ROUTE_PAGE page="login" op="signOutAsUser"}">
							{translate key="user.logOutAs"} {$loggedInUsername|escape}
						</a>
					</li>
				{/if}
			</ul>
		</li>
	{elseif !$notInstalled}
		{if !$hideRegisterLink}
			<li class="header__menu__secondary__item"><a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="register"}">{translate key="navigation.register"}</a></li>
		{/if}
		<li class="header__menu__secondary__item"><a href="{url router=$smarty.const.ROUTE_PAGE page="login"}">{translate key="navigation.login"}</a></li>
	{/if}
</ul>
<div class="header__lang" role="navigation">
    <p class="header__lang__selected">
        {if $currentLocale == "en_US"}
            <a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path='cs_CZ' source=$smarty.server.REQUEST_URI}" class="header__lang__selected__link">
                {translate key="navigation.czech"}
            </a>
        {else}
            <a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path='en_US' source=$smarty.server.REQUEST_URI}" class="header__lang__selected__link">
                    {translate key="navigation.english"}
            </a>
        {/if}

    </p>
</div>