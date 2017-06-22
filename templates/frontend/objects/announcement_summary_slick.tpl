{**
 * templates/frontend/objects/announcement_summary.tpl
 *
 * Copyright (c) 2014-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a summary view of an announcement
 *
 * @uses $announcement Announcement The announcement to display
 * @uses $heading string HTML heading element, default: h2
 *}
{*{if !$heading}
	{assign var="heading" value="h2"}
{/if}*}

<div>
	{*<{$heading}>
		<a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}">
			{$announcement->getLocalizedTitle()|escape}
		</a>
	</{$heading}>*}
	<div>
		{$announcement->getLocalizedDescription()}
	</div>
</div><!-- .obj_announcement_summary -->
