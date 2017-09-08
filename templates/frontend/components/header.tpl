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
    <div class="pkp_structure_page">            
        <div class="pkp_structure_content">
            {*<div style="height:50px; content:' '; ">
                    {* Search form 
                    {include file="frontend/components/searchForm_simple.tpl" header=True}


            </div><!-- .pkp_head_wrapper -->*}
            <div id="pkp_content_main" class="pkp_structure_main" role="main">
