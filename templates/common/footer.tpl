{**
* templates/common/footer.tpl
*
* Copyright (c) 2014 Simon Fraser University Library
* Copyright (c) 2003-2014 John Willinsky
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
*
* Common site footer.
*}

</div><!-- pkp_structure_main -->
</div><!-- pkp_structure_content -->
</div><!-- pkp_structure_body -->

<div class="pkp_structure_foot">

<<<<<<< HEAD
    {if $footerCategories|@count > 0}{* include a subfoot section if there are footer link categories defined *}
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
                <div style="float:left; width: 680px">
                    <a href="http://www.muni.cz/press?lang=cs" target="_self" title="MUNIPRESS"> <img src="{$baseUrl}/images/design/{translate key="footer.publisher.logo"}.png" /></a>
                    
                    <div style="width: 400px;">
                        <h4 style="float:left;">{translate key="footer.contacts"}</h4>
                        <!--<a href="http://www.muni.cz/people/24294" target="_blank" title="PhDr. Alena Mizerová" style="font-weight:bold"> PhDr.&nbsp;Alena&nbsp;Mizerová</a>&nbsp;<em>(ředitelka)</em>,-->
                        <div class="footer_contacts">
                            <a href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;%6d%75%6e%69%70%72%65%73%73@%70%72%65%73%73%2e%6d%75%6e%69%2e%63%7a" target="_blank" title="munipress">munipress@press.muni.cz</a>
                        </div>
                    </div>
                </div>
                <div style="float:right;">
                    <table class="tabulkaZapati">
                        <tbody>
                            <tr>
                                <td>
                                    <a href="{translate key='footer.muni.link'}" title="{translate key='footer.muni'}" target="_blank">
                                        <img src="{$baseUrl}/images/mu_logo_small.png" alt="" class="link_img"/>
                                    </a>
                                </td>
                                <td align="right">
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
</body>
</html>
