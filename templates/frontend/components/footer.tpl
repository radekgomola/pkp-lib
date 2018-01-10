{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common site frontend footer.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}

</div><!-- pkp_structure_main -->

{* Sidebars *}
{*{if empty($isFullWidth)}
    {call_hook|assign:"sidebarCode" name="Templates::Common::Sidebar"}
    {if $sidebarCode}
        <div class="pkp_structure_sidebar left" role="complementary" aria-label="{translate|escape key="common.navigation.sidebar"}">
            {$sidebarCode}
        </div><!-- pkp_sidebar.left -->
    {/if}
{/if}*}
</div><!-- pkp_structure_content -->

{*<footer  id="pkp_content_footer" class="{*pkp_structure_footer_wrapper*}{* footer-light" role="contentinfo">

    <div class="{*pkp_structure_footer*} {*row-main">

        {if $pageFooter}
            <div class="pkp_footer_content">
                {$pageFooter}
            </div>
        {/if}
    </div>
    <div class="row-main">
        <div class="footer-light__copyrights with-img footer-left-block">
            <a href="http://press.muni.cz" class="footer-light__copyrights__img">
                <svg version="1.1" id="Vrstva_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                     width="90px" height="55px" viewBox="0 0 56.693 34.016" enable-background="new 0 0 56.693 34.016" xml:space="preserve">
                    <path id="munipress" fill="#004289" d="M2.834,13.943l0.09-11.36h3.921v1.353c1.015-1.014,2.299-1.759,3.719-1.759
                          c1.398,0,2.39,0.474,3.224,1.759c1.194-1.014,2.772-1.759,4.237-1.759c2.659,0,3.695,1.872,3.695,4.261
                          c0,2.501-0.022,5.003-0.045,7.505h-3.921c0.023-2.186,0.045-4.395,0.045-6.581c0-0.947-0.293-1.803-1.42-1.803
                          c-0.698,0-1.6,0.541-2.073,1.037l-0.091,7.348h-3.921c0.021-2.186,0.044-4.395,0.044-6.581c0-0.947-0.292-1.803-1.419-1.803
                          c-0.699,0-1.601,0.541-2.074,1.037l-0.09,7.348H2.834z M30.567,2.583h3.922l-0.09,11.36h-3.922v-1.239
                          c-0.901,0.878-2.276,1.645-3.673,1.645c-2.412,0-3.719-1.331-3.719-4.439c0-2.322,0.022-4.823,0.045-7.326h3.921
                          c-0.022,2.187-0.045,4.396-0.045,6.74c0,0.924,0.248,1.645,1.42,1.645c0.629,0,1.531-0.541,2.05-1.036L30.567,2.583z M36.418,2.583
                          h3.92v1.241c0.902-0.879,2.277-1.646,3.675-1.646c2.41,0,3.719,1.331,3.719,4.441c0,2.321-0.022,4.823-0.046,7.325h-3.921
                          c0.023-2.186,0.046-4.395,0.046-6.739c0-0.924-0.248-1.646-1.422-1.646c-0.63,0-1.53,0.541-2.051,1.037l-0.089,7.348h-3.922
                          L36.418,2.583z M49.341,13.943h3.921l0.091-11.36h-3.921L49.341,13.943z M2.956,17.517h4.198c2.631,0,4.419,1.345,4.419,3.998
                          c0,3.113-2.651,4.158-4.942,4.158H4.643l-0.081,5.745H2.834L2.956,17.517z M4.623,24.346h2.209c1.466,0,3.013-0.823,3.013-2.832
                          c0-1.487-0.844-2.793-3.093-2.793H4.663L4.623,24.346z M14.124,17.517h4.198c2.631,0,4.419,1.345,4.419,3.655
                          c0,2.27-1.547,3.597-3.495,3.857v0.04c0.924,0.161,1.707,1.447,2.29,2.15l2.792,3.697l-1.526,0.923l-3.274-4.458
                          c-0.844-1.105-1.286-1.909-2.591-1.909h-1.104l-0.081,5.946h-1.748L14.124,17.517z M15.812,24.145h1.728
                          c1.708,0,3.476-0.622,3.476-2.631c0-1.487-0.844-2.793-3.094-2.793h-2.069L15.812,24.145z M26.398,17.517h7.151v1.446h-5.444
                          l-0.041,4.72h5.303v1.447h-5.283l-0.04,4.842h5.583v1.446h-7.351L26.398,17.517z M36.261,29.349
                          c0.744,0.542,1.85,1.024,2.953,1.024c1.628,0,2.753-0.984,2.753-2.53c0-3.536-6.126-2.089-6.126-6.951
                          c0-2.15,1.747-3.656,4.217-3.656c1.366,0,2.571,0.422,3.696,1.084l-0.662,1.266c-0.823-0.542-1.647-1.024-2.953-1.024
                          c-1.205,0-2.572,0.743-2.572,2.43c0,3.053,6.248,2.35,6.248,6.71c0,2.069-1.446,3.998-4.5,3.998c-1.526,0-2.631-0.382-3.817-1.105
                          L36.261,29.349z M46.306,29.349c0.743,0.542,1.849,1.024,2.953,1.024c1.627,0,2.752-0.984,2.752-2.53
                          c0-3.536-6.127-2.089-6.127-6.951c0-2.15,1.748-3.656,4.219-3.656c1.365,0,2.57,0.422,3.696,1.084l-0.664,1.266
                          c-0.823-0.542-1.646-1.024-2.952-1.024c-1.205,0-2.571,0.743-2.571,2.43c0,3.053,6.247,2.35,6.247,6.71
                          c0,2.069-1.445,3.998-4.499,3.998c-1.527,0-2.632-0.382-3.817-1.105L46.306,29.349z"/>
                </svg>
            </a>
            {translate key="footer.nakladatelstvi"}<br />
            {translate key="footer.contact.adresa"} / <a href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;%6d%75%6e%69%70%72%65%73%73@%70%72%65%73%73%2e%6d%75%6e%69%2e%63%7a" target="_blank" title="munipress">munipress@press.muni.cz</a></a>
        </div>
        <div class="footer-light__links footer-right-block">
            <div class="footer-right">
                <div class="inline-block align-left">
                    <a href="{translate key='footer.muni.link'}" title="{translate key='footer.muni'}" target="_blank" >
                        <img src="{$baseUrl}/images/mu_logo_small.png" alt="Masaryk university" class="box-article-list__imgMunipress"/>
                    </a>
                </div>
                <div class="inline-block align-right">
                    <a href="{translate key='footer.uvt.link'}" title="{translate key='footer.uvt'}" target="_blank">
                        <img src="{$baseUrl}/images/uvt_logo_small.png" alt="{translate key='footer.uvt'}" class="box-article-list__imgMunipress"/>
                    </a>
                </div>
                <a href="{url page="about" op="aboutThisPublishingSystem"}">
                    <img alt="{translate key=$packageKey}" src="{$baseUrl}/{$brandImage}" class="box-article-list__imgMunipress">
                </a>
                <br />
                <a href="{$pkpLink}">
                    <img alt="{translate key="common.publicKnowledgeProject"}" src="{$baseUrl}/lib/pkp/templates/images/pkp_brand.png" class="box-article-list__imgMunipress">
                </a>
            </div>

        </div>
    </div>
</footer>*}<!-- pkp_structure_footer_wrapper -->


</div><!-- pkp_structure_page -->

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}

</body>
</html>
