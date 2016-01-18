{**
 * templates/common/footer.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site footer.
 *
 *}
{if $displayCreativeCommons}
	{translate key="common.ccLicense"}
{/if}

{call_hook name="Templates::Common::Footer::PageFooter"}
{if $pageFooter}
        </div>
	<br /><br />
	<div id="pageFooter">{$pageFooter}</div>
{/if}
</div><!-- content -->
</div><!-- main -->
</div><!-- body -->

{if !$currentJournal}

{include file="common/footer_nakl.tpl"}
{/if}

{get_debug_info}
{if $enableDebugStats}{include file=$pqpTemplate}{/if}

</div><!-- container -->
<div id="footerPanel">&nbsp;</div>
</body>
</html>
