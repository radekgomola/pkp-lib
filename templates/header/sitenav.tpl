{**
 * templates/header/sitenav.tpl
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site-Wide Navigation Bar
 *}
<script type="text/javascript">
		<!--
		function changeLanguageCzEn() {ldelim}
			var lang = document.getElementById('tlacitko');
                        
                        var new_locale = lang.value;
                        
			var base_url = "{$currentUrl|escape}";
			var current_url = document.URL;

			var redirect_url = '{url|escape:"javascript" router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path="NEW_LOCALE" source=$smarty.server.REQUEST_URI}';
			redirect_url = redirect_url.replace("NEW_LOCALE", new_locale);

			window.location.href = redirect_url;
		{rdelim}
                //-->
	</script>
<div class="pkp_structure_head_siteNav">
	<ul class="pkp_helpers_flatlist pkp_helpers_align_left">
		{if $isUserLoggedIn}
			{if array_intersect(array(ROLE_ID_SITE_ADMIN), $userRoles)}
				<li><a href="{if $multipleContexts}{url router=$smarty.const.ROUTE_PAGE context="index" page="admin" op="index"}{else}{url router=$smarty.const.ROUTE_PAGE page="admin" op="index"}{/if}">{translate key="navigation.admin"}</a></li>
			{/if}
		{/if}
		{if $multipleContexts}
			<li>{include file="header/contextSwitcher.tpl"}</li>
		{/if}
	</ul>
	<ul class="pkp_helpers_flatlist pkp_helpers_align_right">
		{if $isUserLoggedIn}
			<li class="profile">{translate key="user.hello"}&nbsp;<a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="profile"}">{$loggedInUsername|escape}</a></li>
			<li>{null_link_action id="toggleHelp" key="help.toggleInlineHelpOn"}</li>
			<li><a href="{url router=$smarty.const.ROUTE_PAGE page="login" op="signOut"}">{translate key="user.logOut"}</a></li>
			{if $isUserLoggedInAs}
				<li><a href="{url router=$smarty.const.ROUTE_PAGE page="login" op="signOutAsUser"}">{translate key="user.logOutAs"} {$loggedInUsername|escape}</a></li>
			{/if}
		{elseif !$notInstalled}
			{if !$hideRegisterLink}
				<li><a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="register"}">{translate key="navigation.register"}</a></li>
			{/if}
			<li><a href="{url router=$smarty.const.ROUTE_PAGE page="login"}">{translate key="navigation.login"}</a></li>
		{/if}
                <li>         
                    <form action="#">
                         {translate|assign:"langCzEn" key="jazyk.vyber"}
                         {if $langCzEn == "cs_CZ"}
                             <img src="{$baseUrl}/images/vlajky/cz_square_small_grey2.png" style="float:left;"/>
                             <input id="tlacitko" type="submit" class="lang_cz_en_small en_small" value="en_US" onclick="changeLanguageCzEn(); return false;" />
                         {else}                               
                             <input id="tlacitko" type="button" class="lang_cz_en_small cz_small" value="cs_CZ" onclick="changeLanguageCzEn(); return false;"/>
                             <img src="{$baseUrl}/images/vlajky/en_square_small_grey2.png" />
                         {/if}                    
                     </form>
                 </li>
        </ul>
</div>
