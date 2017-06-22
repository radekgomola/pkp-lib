{**
* templates/common/headerHead.tpl
*
* Copyright (c) 2014-2016 Simon Fraser University Library
* Copyright (c) 2000-2016 John Willinsky
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
*
* Common site header <head> tag and contents.
*}
<head>

    <meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        {$pageTitleTranslated|strip_tags}
    </title>
    {if $requestedOp == 'index' && $metaSearchDescription != ''}
        <meta name="description" content="{$metaSearchDescription|escape}" />
    {/if}
    <meta name="generator" content="{$applicationName} {$currentVersionString|escape}" />
    {$metaCustomHeaders}


    {*
    MuniWeb - hlavičková část
    *}
    <!-- Twitter Card data -->
    <meta name="twitter:card" content="summary">
    <meta name="twitter:site" content="@muni_cz">
    <meta name="twitter:title" content="{$pageTitleTranslated|strip_tags}">
    <meta name="twitter:description" content="Description here">
    <meta name="twitter:image" content="../img/social/twitter.png"> {*<?php /* Twitter Summary card images must be at least 120x120px */ ?>*}

    <!-- Open Graph data -->
    <meta property="og:title" content="<?php echo $title ?>" />
    <meta property="og:url" content="http://www.muni.com/" /> {*<?php /* Aktuální url */ ?>*}
    <meta property="og:description" content="Description here" />
    <meta property="og:image" content="../img/social/facebook.png" />
    <meta property="og:site_name" content="Masarykova univerzita" />        


    <script>
        document.documentElement.className = document.documentElement.className.replace('no-js', 'js');
    </script>
    <script src="{$baseUrl}/plugins/themes/munipress/js/muniweb/modernizr-custom.js" type="text/javascript"></script>

   


    {if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}

    <!-- Base Jquery -->
    {if $allowCDN}
        <script src="//ajax.googleapis.com/ajax/libs/jquery/{$smarty.const.CDN_JQUERY_VERSION}/{if $useMinifiedJavaScript}jquery.min.js{else}jquery.js{/if}"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/{$smarty.const.CDN_JQUERY_UI_VERSION}/{if $useMinifiedJavaScript}jquery-ui.min.js{else}jquery-ui.js{/if}"></script>
    {else}
        <script src="{$baseUrl}/lib/pkp/lib/vendor/components/jquery/{if $useMinifiedJavaScript}jquery.min.js{else}jquery.js{/if}"></script>
        <script src="{$baseUrl}/lib/pkp/lib/vendor/components/jqueryui/{if $useMinifiedJavaScript}jquery-ui.min.js{else}jquery-ui.js{/if}"></script>
    {/if}


     {*Lightcase lightbox*}
    <script src="{$baseUrl}/plugins/themes/munipress/js/lightcase/lightcase.js" type="text/javascript"></script>
    <script type="text/javascript">
        {literal}
        jQuery(document).ready(function ($) {
            $('a[data-rel^="lightcase:cover"]').lightcase({
                 type: 'image'
            });            
            $('a[data-rel^="lightcase:profile"]').lightcase({
                width: 1000,
                maxWidth: 1000
            });  
            $('a[data-rel^="lightcase:flipbook"]').lightcase({
                type: 'iframe',
                width: 1000,
                maxWidth: 1000
            });
        });
        {/literal}
    </script>
    
    {* Load Noto Sans font from Google Font CDN *}
    {* To load extended latin or other character sets, see https://www.google.com/fonts#UsePlace:use/Collection:Noto+Sans *}
    <link href='//fonts.googleapis.com/css?family=Noto+Sans:400,400italic,700,700italic' rel='stylesheet' type='text/css'>

    {load_stylesheet context="frontend" stylesheets=$stylesheets}


    {* Form validator used on search form *}
    {include file="common/validate.tpl"}

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

    <!-- Pines Notify build/cache -->
    <script src="{$baseUrl}/lib/pkp/js/lib/pnotify/pnotify.core.js"></script>
    <script src="{$baseUrl}/lib/pkp/js/lib/pnotify/pnotify.buttons.js"></script>

    {$additionalHeadData}
</head>
