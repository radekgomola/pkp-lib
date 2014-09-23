{**
 * controllers/extrasOnDemand.tpl
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Basic markup for extras on demand widget.
 *}
<script>
	// Initialise JS handler.
	$(function() {ldelim}
		$('#{$id}').pkpHandler(
			'$.pkp.controllers.ExtrasOnDemandHandler');
	{rdelim});
</script>
<div id="{$id}" class="pkp_controllers_extrasOnDemand">
	<div class="toggleExtras">
		<span class="ui-icon"></span>
		<span class="toggleExtras-inactive">{if $moreDetailsText}{translate key=$moreDetailsText}{elseif $moreDetailsTextNT}{$moreDetailsTextNT}{/if}</span>
		<span class="toggleExtras-active">{if $lessDetailsText}{translate key=$lessDetailsText}{elseif $lessDetailsTextNT}{$lessDetailsTextNT}{/if}</span>
	</div>
	<div style="clear:both;"></div>
	<div class="extrasContainer">
		{$extraContent}
	</div>
</div>
