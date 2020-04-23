{**
 * templates/frontend/components/headerHead.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2000-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site header <head> tag and contents.
 *}
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
        {if $monograph}
                {*Specify thumbnail*}
                <meta name="thumbnail" content="{url router=$smarty.const.ROUTE_COMPONENT component="submission.CoverHandler" op="thumbnail" submissionId=$monograph->getId()}" />
            
                {* Display Dublin Core metadata *}
                {include file="frontend/objects/monograph_dublinCore.tpl" monograph=$monograph}

                {* Display Google Scholar metadata *}
                {include file="frontend/objects/monograph_googleScholar.tpl" monograph=$monograph}
        {/if}
	<title>
		{$pageTitleTranslated|strip_tags}
		{* Add the journal name to the end of page titles *}
		{if $requestedPage|escape|default:"index" != 'index' && $currentContext && $currentContext->getLocalizedName()}
			| {$currentContext->getLocalizedName()}
		{/if}
	</title>

	{load_header context="frontend"}
	{load_stylesheet context="frontend"}
</head>
