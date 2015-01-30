{**
 * templates/common/headerHead.tpl
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2000-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site header <head> tag and contents.
 *}
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<title>{$pageTitleTranslated|strip_tags}</title>
	<meta name="description" content="{$metaSearchDescription|escape}" />
	<meta name="keywords" content="{$metaSearchKeywords|escape}" />
	<meta name="generator" content="{$applicationName} {$currentVersionString|escape}" />
	{$metaCustomHeaders}
	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}

	<!-- Base Jquery -->
	{if $allowCDN}
		<script src="https://www.google.com/jsapi"></script>
		<script>{literal}
			// Provide a local fallback if the CDN cannot be reached
			if (typeof google == 'undefined') {
				document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/jquery.min.js' type='text/javascript'%3E%3C/script%3E"));
				document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js' type='text/javascript'%3E%3C/script%3E"));
			} else {
				google.load("jquery", "{/literal}{$smarty.const.CDN_JQUERY_VERSION}{literal}");
				google.load("jqueryui", "{/literal}{$smarty.const.CDN_JQUERY_UI_VERSION}{literal}");
			}
		{/literal}</script>
	{else}
		<script src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script>
		<script src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	{/if}

        <!--Google analytics -->
        <script>
            {literal}
                (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

                ga('create', 'UA-50159706-10', 'auto');
                ga('require', 'displayfeatures');
                ga('send', 'pageview');
            {/literal}
        </script>
        

	<!-- UI elements (menus, forms, etc) -->
	<script src="{$baseUrl}/lib/pkp/js/lib/superfish/hoverIntent.js"></script>
	<script src="{$baseUrl}/lib/pkp/js/lib/superfish/superfish.js"></script>

	{include file="common/validate.tpl"}
	{include file="common/plupload.tpl"}

	{foreach from=$stylesheets item=styleSheetList}{* For all priority sets STYLE_PRIORITY_... *}
		{foreach from=$styleSheetList item=cssUrl}{* For all stylesheet URLs within this priority set *}
			<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
		{/foreach}
	{/foreach}

	<!-- Constants for JavaScript -->
	{include file="common/jsConstants.tpl"}

	<!-- Default global locale keys for JavaScript -->
	{include file="common/jsLocaleKeys.tpl" }

	<!-- Compiled scripts -->
	{if $useMinifiedJavaScript}
		<script src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}

        {*<!-- fancy zoom -->
        <script src="{$baseUrl}/lightboxy/FancyZoom_1.1/js-global/FancyZoom.js" type="text/javascript"></script>
        <script src="{$baseUrl}/lightboxy/FancyZoom_1.1/js-global/FancyZoomHTML.js" type="text/javascript"></script>
      *}
        <!--Highslide-->
{*        <script type="text/javascript" src="{$baseUrl}/lightboxy/highslide/highslide/highslide.js"></script>*}
        <script type="text/javascript" src="{$baseUrl}/lightboxy/highslide/highslide/highslide-full.js"></script>
        <link rel="stylesheet" type="text/css" href="{$baseUrl}/lightboxy/highslide/highslide/highslide.css" />
        <!--[if lt IE 7]>
        <link rel="stylesheet" type="text/css" href="{$baseUrl}/lightboxy/highslide/highslide-ie6.css" />
        <![endif]-->

        {literal}
            <script type="text/javascript">
            //<![CDATA[
            hs.registerOverlay({
                    html: '<div class="closebutton" onclick="return hs.close(this)" title="Close"></div>',
                    position: 'top right',
                    fade: 2 // fading the semi-transparent overlay looks bad in IE
            });

            hs.wrapperClassName = 'borderless';
            //]]>
            </script>
        {/literal}
        {$deprecatedJavascript}

	{$deprecatedThemeStyles}

	{$additionalHeadData}
</head>
