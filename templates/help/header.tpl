{**
 * templates/help/header.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common header for help pages.
 *}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
	<title>{$applicationHelpTranslated}</title>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="description" content="" />
	<meta name="keywords" content="" />

	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}

	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/compiled.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/help.css" type="text/css" />

	<!--použitelné pouze pro muni press-->
  {foreach from=$stylesheets item=cssUrl}
    
    {if $currentJournal} 
       {if $currentJournal->getSetting('useMuniStyle')}
          {if $cssUrl|strstr:"sitestyle.css"}
            <link rel="stylesheet" href="{$cssUrl}" type="text/css" />
          {/if}
       {else}
        {if $cssUrl|strstr:"sitestyle.css"}
        {else}
		      <link rel="stylesheet" href="{$cssUrl}" type="text/css" />
        {/if}
      {/if}
    {else}
      {if $cssUrl|strstr:"sitestyle.css"}
        <link rel="stylesheet" href="{$cssUrl}" type="text/css" />
      {/if}
    {/if}
	{/foreach}

	<!-- Base Jquery -->
	{if $allowCDN}<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script type="text/javascript">{literal}
		<!--
		// Provide a local fallback if the CDN cannot be reached
		if (typeof google == 'undefined') {
			document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/jquery.min.js' type='text/javascript'%3E%3C/script%3E"));
			document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js' type='text/javascript'%3E%3C/script%3E"));
		} else {
			google.load("jquery", "{/literal}{$smarty.const.CDN_JQUERY_VERSION}{literal}");
			google.load("jqueryui", "{/literal}{$smarty.const.CDN_JQUERY_UI_VERSION}{literal}");
		}
		// -->
	{/literal}</script>
	{else}
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	{/if}

	<!-- Compiled scripts -->
	{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}

	{$additionalHeadData}
</head>
{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
<body id="pkp-{$pageTitle|replace:'.':'-'}">
{literal}
<script type="text/javascript">
<!--
    if (self.blur) { self.focus(); }
// -->
</script>
{/literal}



<div id="container">
    {translate|assign:"help" key="languages.help"}
    <span id="{if $help == "cestina"}help_cz{elseif $help == "deutsch"}help_de{else}help_en{/if}"></span>

<div id="body">
<div id="top"></div>

