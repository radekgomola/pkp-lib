{**
* templates/frontend/components/breadcrumbs.tpl
*
* Copyright (c) 2014-2016 Simon Fraser University Library
* Copyright (c) 2003-2016 John Willinsky
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
*
* @brief Display a breadcrumb nav item showing the current page. This basic
*  version is for top-level pages which only need to show the Home link. For
*  category- and series-specific breadcrumb generation, see
*  templates/frontend/components/breadcrumbs_catalog.tpl.
*
* @uses $currentTitle string The title to use for the current page.
* @uses $currentTitleKey string Translation key for title of current page.
*}

{*<nav class="cmp_breadcrumbs" role="navigation" aria-label="{translate key="navigation.breadcrumbLabel"}">
<ol>
<li>
<a href="{url page="index" router=$smarty.const.ROUTE_PAGE}">
{translate key="common.homepageNavigationLabel"}
</a>
<span class="separator">{translate key="navigation.breadcrumbSeparator"}</span>
</li>
<li class="current">
<h1>
{if $currentTitleKey}
{translate key=$currentTitleKey}
{else}
{$currentTitle|escape}
{/if}
</h1>
</li>
</ol>
</nav>*}
<nav class="menu-breadcrumb" role="navigation" aria-label="{translate key="navigation.breadcrumbLabel"}">
        <p>
            <a href="{url page="index" router=$smarty.const.ROUTE_PAGE}" class="menu-breadcrumb__item menu-breadcrumb__item--home">
                {translate key="common.homepageNavigationLabel"}
            </a>
            <span class="icon icon-angle-right"></span>
            <strong class="menu-breadcrumb__item">
            {if $currentTitleKey}
                {translate key=$currentTitleKey}
            {else}
                {$currentTitle|escape}
            {/if}
            </strong>
        </p>
        {* Count of new releases being dispalyed *}
	<div class="monograph_count">
		{translate key="catalog.browseTitles" numTitles=$monographCount}
	</div>
</nav>