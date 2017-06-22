{**
* controllers/extrasOnDemand.tpl
*
* Copyright (c) 2014-2016 Simon Fraser University Library
* Copyright (c) 2003-2016 John Willinsky
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
*
* Basic markup for extras on demand widget.
*}
<script>
    // Initialise JS handler.
    $(function () {ldelim}
            $('#{$id}').pkpHandler(
                    '$.pkp.controllers.ExtrasOnDemandHandler',
    {ldelim}
        {if $active}
                                    active: {$active}
    {/if}
    {rdelim});
    {rdelim});
</script>
<div id="{$id}" class="pkp_controllers_extrasOnDemand">
    <a href="#" class="toggleExtras">
        {if $moreDetailsText && $lessDetailsText}
            <span class="toggleExtras-inactive">{translate key=$moreDetailsText}</span>
            <span class="toggleExtras-active">{translate key=$lessDetailsText}</span>
            <span class="fa fa-plus"></span>
        {/if}
        {if $moreDetailsTextNT && $lessDetailsTextNT}
            <span class="toggleExtras-inactive"><a href="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$cesta}">{$moreDetailsTextNT}</a></span>

            <span class="toggleExtras-active">{$lessDetailsTextNT}</span>
        {/if}
    </a>
    <div class="extrasContainer container">
        {$extraContent}
    </div>
</div>
