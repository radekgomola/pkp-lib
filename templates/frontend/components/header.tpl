{**
* lib/pkp/templates/frontend/components/header.tpl
*
* Copyright (c) 2014-2017 Simon Fraser University
* Copyright (c) 2003-2017 John Willinsky
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
*
* @brief Common frontend site header.
*
* @uses $isFullWidth bool Should this page be displayed without sidebars? This
*       represents a page-level override, and doesn't indicate whether or not
*       sidebars have been configured for thesite.
*}
{strip}
    {* Determine whether a logo or title string is being displayed *}
    {assign var="showingLogo" value=true}
    {if $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
        {assign var="showingLogo" value=false}
    {/if}
{/strip}
<!DOCTYPE html>
<!--[if lte IE 9]><html class="old-browser no-js" lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}"><![endif]-->
<!--[if IE 9 ]> <html class="ie9 no-js" lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html class="no-js" lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}"><!--<![endif]-->

    {*<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">*}

{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
{include file="frontend/components/headerHead.tpl"}
<body {*class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}" *}dir="{$currentLocaleLangDir|escape|default:"ltr"}">

    {*<div class="cmp_skip_to_content">
    <a href="#pkp_content_main">{translate key="navigation.skip.main"}</a>
    <a href="#pkp_content_nav">{translate key="navigation.skip.nav"}</a>
    <a href="#pkp_content_footer">{translate key="navigation.skip.footer"}</a>
    
    </div>*}
    <div class="pkp_structure_page">

        {* Header *}
        <header {*class="pkp_structure_head" id="headerNavigationContainer" role="banner"*} class="header header--nav-under">
            <div {*class="pkp_head_wrapper"*} class="row-main">
                <p class="header__logo" role="banner">
                    <a href="#">
                        {include file="core:frontend/components/logo.tpl"}
                    </a>
                </p>

                {* Primary site navigation *}
                {if $currentContext}
                    {* Search form *}
                    {include file="frontend/components/searchForm_simple.tpl" header=True}
                    <nav id="menu-main" role="navigation" {*class="pkp_navigation_primary_row"*} class="header__menu" aria-label="{translate|escape key="common.navigation.site"}">
                        <div {*class="pkp_navigation_primary_wrapper"*} class="header__menu-main">

                            {* Primary navigation menu for current application *}
                            {include file="frontend/components/primaryNavMenu.tpl"}

                        </div>
                        <a href="#" class="header__menu__title">
                            <span class="icon icon-bars"></span>
                            Menu
                        </a>
                        <div class="header__menu-toggle" aria-hidden="true"></div>
                    </nav>
                {/if}
                <nav class="pkp_navigation_user_wrapper navDropdownMenu" id="navigationUserWrapper header__userNav" aria-label="{translate|escape key="common.navigation.user"}">
                    <ul id="navigationUser" class="pkp_navigation_user pkp_nav_list">
                        {if $isUserLoggedIn}
                            <li class="profile {if $unreadNotificationCount} has_tasks{/if} header__menu__secondary__item has_submenu" aria-haspopup="true" aria-expanded="false">
                                <a href="{url router=$smarty.const.ROUTE_PAGE page="submissions"}">
                                    {$loggedInUsername|escape}
                                    <span class="task_count">
                                        {$unreadNotificationCount}
                                    </span>
                                </a>
                                <ul>
                                    {if array_intersect(array(ROLE_ID_MANAGER, ROLE_ID_ASSISTANT, ROLE_ID_REVIEWER, ROLE_ID_AUTHOR), (array)$userRoles)}
                                        <li class="header__menu__secondary__item">
                                            <a href="{url router=$smarty.const.ROUTE_PAGE page="submissions"}">
                                                {translate key="navigation.dashboard"}
                                                <span class="task_count">
                                                    {$unreadNotificationCount}
                                                </span>
                                            </a>
                                        </li>
                                    {/if}
                                    <li class="header__menu__secondary__item">
                                        <a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="profile"}">
                                            {translate key="common.viewProfile"}
                                        </a>
                                    </li>
                                    {if array_intersect(array(ROLE_ID_SITE_ADMIN), (array)$userRoles)}
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
                            <li class="header__menu__secondary__item">
                                {if $currentLocale == "en_US"}
                                    <a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path='cs_CZ' source=$smarty.server.REQUEST_URI}" class="header__lang__selected__link">
                                        {translate key="navigation.czech"}
                                    </a>
                                {else}
                                    <a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path='en_US' source=$smarty.server.REQUEST_URI}" class="header__lang__selected__link">
                                        {translate key="navigation.english"}
                                    </a>
                                {/if}
                            </li>
                        {else}
                            {if !$disableUserReg}
                                <li class="header__menu__secondary__item"><a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="register"}">{translate key="navigation.register"}</a></li>
                                {/if}
                            <li class="header__menu__secondary__item"><a href="{url router=$smarty.const.ROUTE_PAGE page="login"}">{translate key="navigation.login"}</a></li>
                            <li class="header__menu__secondary__item">
                                {if $currentLocale == "en_US"}
                                    <a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path='cs_CZ' source=$smarty.server.REQUEST_URI}" class="header__lang__selected__link">
                                        {translate key="navigation.czech"}
                                    </a>
                                {else}
                                    <a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path='en_US' source=$smarty.server.REQUEST_URI}" class="header__lang__selected__link">
                                        {translate key="navigation.english"}
                                    </a>
                                {/if}
                            </li>
                        {/if}
                    </ul>
                    {* <div class="header__lang" role="navigation" style="">
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
                    </div>*}
                </nav><!-- .pkp_navigation_user_wrapper -->

            </div><!-- .pkp_head_wrapper -->
        </header><!-- .pkp_structure_head -->

        {* Wrapper for page content and sidebars *}
        {if $isFullWidth}
            {assign var=hasSidebar value=0}
        {/if}
        <div class="pkp_structure_content{if $hasSidebar} has_sidebar{/if}">
            <div id="pkp_content_main" class="pkp_structure_main" role="main">
