{**
 * templates/common/frontend/header.tpl
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site header.
 *}
<!DOCTYPE html>
<html>
    {if $pageTitleName}
        {assign var=pageTitleTranslated value=$pageTitleName}
    {else}
        {if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
    {/if}
    {include file="core:frontend/components/headerHead.tpl"}
<body>

