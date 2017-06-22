{**
 * templates/common/footer.tpl
 *
 * Copyright (c) 2014-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site footer.
 *}

</div><!-- pkp_structure_main -->
</div><!-- pkp_structure_body -->

<div class="pkp_structure_footer" role="contentinfo">
	<div class="pkp_brand_footer">
		<a href="{url page="about" op="aboutThisPublishingSystem"}">
			<img alt="{translate key=$packageKey}" src="{$baseUrl}/{$brandImage}">
		</a>
		<a href="{$pkpLink}">
			<img alt="{translate key="common.publicKnowledgeProject"}" src="{$baseUrl}/lib/pkp/templates/images/pkp_brand.png">
		</a>
	</div>
</div>

    {*{if $footerCategories|@count > 0}{* include a subfoot section if there are footer link categories defined 
            <div class="pkp_structure_subfoot">
                <div class="pkp_structure_content horniZapati">
                    {foreach from=$footerCategories item=category name=loop}
                        {assign var=links value=$category->getLinks()}
                        <div class="unit size1of{$footerCategories|@count} {if $smarty.foreach.loop.last}lastUnit{/if}">
                            <h4>{$category->getLocalizedTitle()}</h4>
                            <ul>
                                {foreach from=$links item=link}
                                    <li><a href="{$link->getLocalizedUrl()}" target="_blank">{$link->getLocalizedTitle()|strip_unsafe_html}</a></li>
                                    {/foreach}
                                    {if $links|@count < $maxLinks}
                                        {section name=padding start=$links|@count loop=$maxLinks step=1}
                                        <li class="pkp_helpers_invisible">&nbsp;</li>
                                        {/section}
                                    {/if}
                            </ul>
                        </div>
                    {/foreach}

                </div><!-- pkp_structure_content -->
            </div><!-- pkp_structure_subfoot -->

        {/if}
        <div class="pkp_structure_subfoot">
            <div class="pkp_structure_content">
                <div class="munipress_block">
                    <a href="http://www.muni.cz/press?lang=cs" target="_self" title="MUNIPRESS"> <img src="{$baseUrl}/images/design/{translate key="footer.publisher.logo"}.png" alt="Munipress"/></a>
                    
                    <div class="contact_block">
                        <h4>{translate key="footer.contacts"}</h4>
                        <div class="footer_contacts">
                            <a href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;%6d%75%6e%69%70%72%65%73%73@%70%72%65%73%73%2e%6d%75%6e%69%2e%63%7a" target="_blank" title="munipress">munipress@press.muni.cz</a>
                        </div>
                    </div>
                </div>
                <div class="support_block">
                    <table class="tabulkaZapati">
                        <tbody>
                            <tr>
                                <td>
                                    <a href="{translate key='footer.muni.link'}" title="{translate key='footer.muni'}" target="_blank">
                                        <img src="{$baseUrl}/images/mu_logo_small.png" alt="Masaryk university" class="link_img"/>
                                    </a>
                                </td>
                                <td style="float: right;">
                                    <a href="{translate key='footer.uvt.link'}" title="{translate key='footer.uvt'}" target="_blank">
                                        <img src="{$baseUrl}/images/uvt_logo_small.png" alt="{translate key='footer.uvt'}" class="link_img"/>
                                    </a>
                                </td>

                            </tr>
                        </tbody>
                    </table>
                    <a href="{url page="about" op="aboutThisPublishingSystem"}"><img class="link_img" alt="{translate key=$packageKey}" src="{$baseUrl}/{$brandImage}"/></a>
                    <a href="{$pkpLink}"><img class="link_img pkp_helpers_clear" alt="{translate key="common.publicKnowledgeProject"}" src="{$baseUrl}/lib/pkp/templates/images/pkp_brand.png"/></a>	

                </div>
            </div><!-- pkp_structure_content -->
            <div class="pkp_structure_content">
            {if $pageFooter}{$pageFooter}{/if}
            {call_hook name="Templates::Common::Footer::PageFooter"}
        </div><!-- pkp_structure_content -->
    </div><!-- pkp_structure_subfoot -->

</div><!-- pkp_structure_foot -->

</div><!-- pkp_structure_page -->

{$additionalFooterData}
<!-- Piwik disabled cookies-->
<script type="text/javascript">
  var _paq = _paq || [];
  _paq.push(['disableCookies']);
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  _paq.push([‘setLinkTrackingTimer’, 750]);
  (function() {ldelim}
    var u="https://journals.muni.cz/analytics/";
    _paq.push(['setTrackerUrl', u+'piwik.php']);
    _paq.push(['setSiteId', 12]);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
  {rdelim})();
</script>
<noscript><p><img src="https://journals.muni.cz/analytics/piwik.php?idsite=12" style="border:0;" alt="" /></p></noscript>
<!-- End Piwik Code -->
*}
<script src="{$baseUrl}/js/foundation/js/vendor/what-input.js"></script>
<script src="{$baseUrl}/js/foundation/js/vendor/foundation.js"></script>
<script src="{$baseUrl}/js/foundation/js/app.js"></script>
<script type="text/javascript">
	// Initialize JS handler
	$(function() {ldelim}
		$('#pkpHelpPanel').pkpHandler(
			'$.pkp.controllers.HelpPanelHandler',
			{ldelim}
				helpUrl: {url|json_encode page="help" escape=false},
				helpLocale: '{$currentLocale|substr:0:2}',
			{rdelim}
		);
	{rdelim});
</script>
<div id="pkpHelpPanel" class="pkp_help_panel" tabindex="-1">
	<div class="panel">
		<div class="header">
			<a href="#" class="pkpHomeHelpPanel home">
				{translate key="help.toc"}
			</a>
			<a href="#" class="pkpCloseHelpPanel close">
				{translate key="common.close"}
			</a>
		</div>
		<div class="content">
			{include file="common/loadingContainer.tpl"}
		</div>
		<div class="footer">
			<a href="#" class="pkpPreviousHelpPanel previous">
				{translate key="help.previous"}
			</a>
			<a href="#" class="pkpNextHelpPanel next">
				{translate key="help.next"}
			</a>
		</div>
	</div>
</div>

</body>
</html>
