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
<body dir="{$currentLocaleLangDir|escape|default:"ltr"}">
    <div class="pkp_structure_page">            

        <header class="header header--nav-under">
            <div class="row-main">
                <div class="header__menu-main">
                <nav id="menu-main" role="navigation" class="header__menu" aria-label="{translate|escape key="common.navigation.site"}">
                    <ul class="header__menu__primary">
                        <li class="header__menu__primary__item">
                            <a href="{url router=$smarty.const.ROUTE_PAGE page="catalog"}" class="header__menu__primary__link" >
                                {translate key="navigation.catalog"}
                            </a>
                        </li>
                    </ul>
                </nav>
                {* Search form *}
                {include file="frontend/components/searchForm_simple.tpl" header=True}

                </div>
            </div><!-- .pkp_head_wrapper -->
        </header>
        <div class="pkp_structure_content">
            <div id="pkp_content_main" class="pkp_structure_main" role="main">
