{**
 * header.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site header.
 *}
{strip}
 {*vytváří záplatu pro chybu menu, kdy se nezobrazuje správně nadpis*}
{if $pageTitle == "common.openJournalSystems"}
{if $requestedPage=="user"}
  {assign var=pageTitle value='user.register'}
{elseif $requestedPage=="issue"}
{assign var=pageTitle value='journal.currentIssue'}
{/if}
{/if}
{*jenom po sem*}

{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
{if $pageCrumbTitle}
	{translate|assign:"pageCrumbTitleTranslated" key=$pageCrumbTitle}
{elseif !$pageCrumbTitleTranslated}
	{assign var="pageCrumbTitleTranslated" value=$pageTitleTranslated}
{/if}
{/strip}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
   
    {*<script type="text/javascript">
        if(!localStorage["alertdisplayed2"]) {ldelim}
                alert("System has been updated! If you find any kind of problem contact an administrator at gomola@press.muni.cz, please!");
                localStorage["alertdisplayed2"] = true;
                {rdelim}
    </script>*}
    
    {*{if $loggedInUsername != "admin"}
        <meta http-equiv="refresh" content="0;url={$baseUrl}/underConstruction.html" />
    {/if}*}
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
        
        <title>{$pageTitleTranslated|strip_tags:true}</title>
	<meta name="description" content="{if $metaSearchDescription!=''}{$metaSearchDescription|escape}{else}{translate key=journals.munipress.description}{/if}" />
	<meta name="keywords" content="{if $metaSearchKeywords!=''}{$metaSearchKeywords|escape}{else}{translate key=journals.munipress.keywords}{/if}" />
	<meta name="generator" content="{$applicationName} {$currentVersionString|escape}" />
	{$metaCustomHeaders}
	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}
	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/pkp.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/compiled.css" type="text/css" />
  <link rel="stylesheet" href="{$baseUrl}/styles/pdfView.css" type="text/css" />
  <link rel="stylesheet" href="{$baseUrl}/styles/grafika.css" type="text/css" />
  
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

	{call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
	{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}
	
  <!-- upravuji používání korporátního designu. ve chvíli kdy je použit korporátní design, tak není povolen levý blok -->
  {if $leftSidebarCode || $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/sidebar.css" type="text/css" />{/if}
  {if $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/rightSidebar.css" type="text/css" />{/if}
  {if $currentJournal}
  	{if !$currentJournal->getSetting('useMuniStyle') && $leftSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/leftSidebar.css" type="text/css" />{/if}
  	{if !$currentJournal->getSetting('useMuniStyle') && $leftSidebarCode && $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/bothSidebars.css" type="text/css" />{/if}
  {/if}
	
  <!--použitelné pouze pro muni press. Upravuje to zapínání a vypínání korporátního designu-->
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

	<!-- Default global locale keys for JavaScript -->
	{include file="common/jsLocaleKeys.tpl" }

	<!-- Compiled scripts -->
	{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}

	<!-- Form validation -->
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/validate/jquery.validate.js"></script>
	<script type="text/javascript">
		<!--
		// initialise plugins
		{literal}
		$(function(){
			jqueryValidatorI18n("{/literal}{$baseUrl}{literal}", "{/literal}{$currentLocale}{literal}"); // include the appropriate validation localization
			{/literal}{if $validateId}{literal}
				$("form[name={/literal}{$validateId}{literal}]").validate({
					errorClass: "error",
					highlight: function(element, errorClass) {
						$(element).parent().parent().addClass(errorClass);
					},
					unhighlight: function(element, errorClass) {
						$(element).parent().parent().removeClass(errorClass);
					}
				});
			{/literal}{/if}{literal}
			$(".tagit").live('click', function() {
				$(this).find('input').focus();
			});
		});
		// -->
                
		{/literal}
	</script>
        
        
        <script type="text/javascript">
            {literal}
                function detectIE() {
                    var ua = window.navigator.userAgent;
                    var msie = ua.indexOf('MSIE ');
                    var trident = ua.indexOf('Trident/');

                    if (msie > 0) {
                        // IE 10 or older => return version number
                        return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
                    }

                    if (trident > 0) {
                        // IE 11 (or newer) => return version number
                        var rv = ua.indexOf('rv:');
                        return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
                    }

                    // other browser
                    return false;
                } 
                function vypisKdyzIE(IE10,IE11,vypis){
                    if(detectIE()==10){
                        document.write(IE10);
                        document.write(vypis);
                    }
                    if(detectIE()==11){
                        document.write(IE11);
                        document.write(vypis);
                    }
                }
            {/literal}
        </script>
        

	{if $hasSystemNotifications}
		{url|assign:fetchNotificationUrl page='notification' op='fetchNotification' escape=false}
		<script type="text/javascript">
			$(function(){ldelim}
				$.get('{$fetchNotificationUrl}', null,
					function(data){ldelim}
						var notifications = data.content;
						var i, l;
						if (notifications && notifications.general) {ldelim}
							$.each(notifications.general, function(notificationLevel, notificationList) {ldelim}
								$.each(notificationList, function(notificationId, notification) {ldelim}
									$.pnotify(notification);
								{rdelim});
							{rdelim});
						{rdelim}
				{rdelim}, 'json');
			{rdelim});
		</script>
	{/if}{* hasSystemNotifications *}

	{$additionalHeadData}
</head>
<body id="pkp-{$pageTitle|replace:'.':'-'}">
<div id="container">
    {translate|assign:"help" key="languages.help"}
    <span id="{if $help == "cestina"}help_cz{else}help_en{/if}"></span>
<div id="header">
<div id="headerTitle">
<!--přídán odkaz v hlavičce a upraveno zobrazování loga-->
<h1>
<a href="{url page="index"}" class="header_link" style="text-decoration:none; outline:none;">

{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
<div class="header_logo">
	<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogoAltText != ''}alt="{$displayPageHeaderLogoAltText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
</div>
{/if}
{if $displayPageHeaderTitle && is_array($displayPageHeaderTitle)}
	<img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" style="display: inline" width="{$displayPageHeaderTitle.width|escape}" height="{$displayPageHeaderTitle.height|escape}" {if $displayPageHeaderTitleAltText != ''}alt="{$displayPageHeaderTitleAltText|escape}"{else}alt="{translate key="common.pageHeader.altText"}"{/if} />
{elseif $displayPageHeaderTitle}
	{$displayPageHeaderTitle}
{elseif $alternatePageHeader}
	{$alternatePageHeader}
{elseif $siteTitle}
	{$siteTitle}
{else}
	{$siteTitle}
{/if}

</a>
</h1>
</div>
</div>

<div id="body">

<!-- upraveno aby se nezobrazoval levý blok ve chvíli, kdy jej někdo použije s korporátním designem-->
{if $currentJournal}
  	<div id="sidebar">
      {assign var=blok value="0"} 
      {if $rightSidebarCode}   
  			<div id="rightSidebar">
  				{$rightSidebarCode}
          {include file="nove_pridane/blok_jmc.tpl"}
          {assign var=blok value="1"}
  			</div>
      {/if}
      {if !$currentJournal->getSetting('useMuniStyle') && $leftSidebarCode}
        <div id="leftSidebar">
    			{$leftSidebarCode}
          {if ! blok=="1"}
          {include file="nove_pridane/blok_jmc.tpl"}
          {/if}
    		</div>
      {/if}
  	</div>
{else}
  {if $rightSidebarCode}
    <div id="sidebar">    
			<div id="rightSidebar">
				{$rightSidebarCode}
        {include file="nove_pridane/blok_odkazy.tpl"}
			</div>
  	</div>
  {/if}
{/if}

<div id="main">
{include file="common/navbar2.tpl"}

{include file="common/breadcrumbs.tpl"}
<div class="headTitle">
<h2>{$pageTitleTranslated}</h2>

{if $pageSubtitle && !$pageSubtitleTranslated}{translate|assign:"pageSubtitleTranslated" key=$pageSubtitle}{/if}
</div>
<div id="content">
{if $pageSubtitleTranslated}
	<h3>{$pageSubtitleTranslated}</h3>
  <br />
{/if}



