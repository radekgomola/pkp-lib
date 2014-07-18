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

    {if $footerCategories|@count > 0}{* include a subfoot section if there are footer link categories defined *}
            <div class="pkp_structure_subfoot horniZapati">
                <div class="pkp_structure_content">
                    {foreach from=$footerCategories item=category name=loop}
                        {assign var=links value=$category->getLinks()}
                        <div class="unit size1of{$footerCategories|@count} {if $smarty.foreach.loop.last}lastUnit{/if}">
                            <h4>{$category->getLocalizedTitle()}</h4>
                            <ul>
                                {foreach from=$links item=link}
                                    <li><a href="{$link->getUrl()}" target="_blank">{$link->getLocalizedTitle()}</a></li>
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
                <div style="float:left">
                    {translate key="footer.publisher"}<strong> <a href="http://www.muni.cz/press?lang=cs" target="_blank" title="MUNIPRESS"> MUNIPRESS</a></strong><br /><br />
                    <strong>{translate key="footer.contacts"}</strong><br />
                    <!--<a href="http://www.muni.cz/people/24294" target="_blank" title="PhDr. Alena Mizerová" style="font-weight:bold"> PhDr.&nbsp;Alena&nbsp;Mizerová</a>&nbsp;<em>(ředitelka)</em>,-->
                    <a href="http://www.muni.cz/press/people/110512" target="_blank" title="PhDr. Lea Novotná" style="font-weight:bold"> PhDr.&nbsp;Lea&nbsp;Novotná</a>&nbsp;<em>{translate key="footer.novotna"}</em>, 
                    <!--<a href="http://www.muni.cz/press/people/180818" target="_blank" title="Mgr. Martina Tlachová" style="font-weight:bold"> Mgr.&nbsp;Martina&nbsp;Tlachová</a>&nbsp;<em>(tajemnice,&nbsp;marketing)</em>,-->
                    <!--<a href="http://www.muni.cz/press/people/2368" target="_blank" title="Mgr. Radka Vyskočilová" style="font-weight:bold"> Mgr.&nbsp;Radka&nbsp;Vyskočilová</a>&nbsp;<em>(odborná&nbsp;redaktorka)</em>,-->
                    <a href="http://www.muni.cz/press/people/29774" target="_blank" title="Mgr. Lenka Brodecká" style="font-weight:bold"> Mgr.&nbsp;Lenka&nbsp;Brodecká</a>&nbsp;<em>{translate key="footer.brodecka"}</em>, 
                    <!--<a href="http://www.muni.cz/press/people/107259" target="_blank" title="Alena Rokosová" style="font-weight:bold"> Alena&nbsp;Rokosová</a>&nbsp;<em>(distribuce,&nbsp;marketing)</em>-->
                    <a href="http://www.muni.cz/press/people/256769" target="_blank" title="Mgr. Radek Gomola" style="font-weight:bold"> Mgr.&nbsp;Radek Gomola</a>&nbsp;<em>{translate key="footer.gomola"}</em>

                    <br /><br />
                    <strong>&copy; </strong><a href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;%70%61%76%65%6c.%6b%72%65%70%65%6c%61@%67%6d%61%69%6c.%63%6f%6d" title="e-mail">Mgr. Pavel Křepela / Line&amp;Curve </a> 
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
