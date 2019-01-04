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
{if empty($isFullWidth)}
    {call_hook|assign:"sidebarCode" name="Templates::Common::Sidebar"}
    {if $sidebarCode}
        <div class="pkp_structure_sidebar left" role="complementary" aria-label="{translate|escape key="common.navigation.sidebar"}">
            {$sidebarCode}
        </div><!-- pkp_sidebar.left -->
    {/if}
{/if}
</div><!-- pkp_structure_content -->

<footer  id="pkp_content_footer" class="{*pkp_structure_footer_wrapper*} footer-light" role="contentinfo">

    <div class="{*pkp_structure_footer*} row-main">

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
                     width="80px" height="45px" viewBox="0 0 90 55" enable-background="new 0 0 90 55" xml:space="preserve">
                    <path id="munipress" fill="#0000DC" d="M4.433,4.008h2.725v17.5H4.433V4.008z M7.258,4.008h0.925l1.7,17.5H8.958L7.258,4.008z M11.683,4.008h0.925
                          l-1.7,17.5H9.983L11.683,4.008z M12.708,4.008h2.75v17.5h-2.75V4.008z M25.783,4.008v13.375c0,0.45,0.17,0.833,0.512,1.15
                          c0.342,0.317,0.721,0.475,1.138,0.475c0.417,0,0.796-0.158,1.138-0.475c0.341-0.316,0.512-0.7,0.512-1.15V4.008h2.75v13.475
                          c0,0.767-0.208,1.467-0.625,2.1s-0.962,1.137-1.637,1.512c-0.675,0.375-1.388,0.563-2.138,0.563s-1.462-0.188-2.138-0.563
                          c-0.675-0.375-1.221-0.879-1.637-1.512c-0.417-0.633-0.625-1.333-0.625-2.1V4.008H25.783z M43.058,4.008v17.5h-2.75v-17.5H43.058z
                          M44.108,4.008l2.601,17.5h-0.951l-2.601-17.5H44.108z M49.559,4.008v17.5h-2.75v-17.5H49.559z M61.033,20.533V4.983h-2.35V4.008
                          h7.475v0.975h-2.375v15.55h2.375v0.975h-7.475v-0.975H61.033z M10.608,34.009c0.75,0,1.446,0.188,2.088,0.563
                          c0.641,0.375,1.15,0.884,1.525,1.524c0.375,0.643,0.563,1.338,0.563,2.088v1.801c0,0.75-0.188,1.445-0.563,2.087
                          s-0.879,1.15-1.513,1.525s-1.333,0.563-2.1,0.563H7.533v7.35h-1.35v-17.5H10.608z M12.583,42.021c0.566-0.575,0.85-1.305,0.85-2.188
                          v-1.625c0-0.816-0.292-1.513-0.875-2.088c-0.583-0.574-1.275-0.862-2.075-0.862h-2.95v7.625h2.95
                          C11.316,42.884,12.016,42.597,12.583,42.021z M28.058,34.009c0.75,0,1.446,0.188,2.087,0.563s1.15,0.884,1.525,1.524
                          c0.375,0.643,0.563,1.338,0.563,2.088v1.75c0,0.7-0.162,1.346-0.487,1.938s-0.767,1.075-1.325,1.45s-1.179,0.588-1.862,0.638
                          l4.275,7.55h-1.55l-4.15-7.4h-2.275v7.4h-1.35v-17.5H28.058z M30.058,41.972c0.566-0.575,0.85-1.304,0.85-2.188v-1.574
                          c0-0.816-0.296-1.513-0.888-2.088c-0.592-0.574-1.288-0.862-2.087-0.862h-3.075v7.575h3.075
                          C28.783,42.834,29.491,42.546,30.058,41.972z M41.108,34.009h8.351v1.25h-7v6.45h6.7v1.25h-6.7v7.3h7v1.25h-8.351V34.009z
                          M60.246,51.134c-0.658-0.35-1.18-0.846-1.563-1.487c-0.385-0.642-0.576-1.362-0.576-2.163v-0.6h1.352v0.575
                          c0,0.533,0.137,1.021,0.412,1.462c0.275,0.442,0.645,0.792,1.111,1.051c0.467,0.258,0.959,0.387,1.477,0.387
                          c0.516,0,1-0.129,1.449-0.387c0.449-0.259,0.813-0.608,1.088-1.051c0.275-0.441,0.412-0.929,0.412-1.462v-1.025
                          c0-0.933-0.297-1.612-0.887-2.037c-0.592-0.425-1.396-0.746-2.414-0.963c-1.066-0.25-2-0.691-2.799-1.325
                          c-0.801-0.633-1.201-1.591-1.201-2.874v-1.201c0-0.783,0.191-1.49,0.576-2.125c0.383-0.633,0.904-1.133,1.563-1.5
                          c0.658-0.365,1.387-0.549,2.188-0.549c0.799,0,1.529,0.184,2.188,0.549c0.658,0.367,1.178,0.867,1.563,1.5
                          c0.383,0.635,0.574,1.342,0.574,2.125v0.65h-1.35v-0.625c0-0.533-0.137-1.021-0.412-1.463c-0.275-0.441-0.643-0.791-1.1-1.049
                          c-0.459-0.259-0.947-0.389-1.463-0.389c-0.518,0-1.004,0.13-1.463,0.389c-0.459,0.258-0.824,0.607-1.1,1.049
                          c-0.275,0.442-0.412,0.93-0.412,1.463v1.176c0,0.916,0.295,1.583,0.887,2c0.592,0.416,1.379,0.741,2.363,0.975
                          c1.1,0.25,2.049,0.696,2.85,1.337c0.799,0.643,1.199,1.597,1.199,2.863v1.074c0,0.801-0.191,1.521-0.574,2.163
                          c-0.385,0.642-0.904,1.138-1.563,1.487s-1.389,0.525-2.188,0.525C61.633,51.659,60.904,51.483,60.246,51.134z M77.746,51.134
                          c-0.658-0.35-1.18-0.846-1.563-1.487c-0.385-0.642-0.576-1.362-0.576-2.163v-0.6h1.352v0.575c0,0.533,0.137,1.021,0.412,1.462
                          c0.275,0.442,0.645,0.792,1.111,1.051c0.467,0.258,0.959,0.387,1.477,0.387c0.516,0,1-0.129,1.449-0.387
                          c0.449-0.259,0.813-0.608,1.088-1.051c0.275-0.441,0.412-0.929,0.412-1.462v-1.025c0-0.933-0.297-1.612-0.887-2.037
                          c-0.592-0.425-1.396-0.746-2.414-0.963c-1.066-0.25-2-0.691-2.799-1.325c-0.801-0.633-1.201-1.591-1.201-2.874v-1.201
                          c0-0.783,0.191-1.49,0.576-2.125c0.383-0.633,0.904-1.133,1.563-1.5c0.658-0.365,1.387-0.549,2.188-0.549
                          c0.799,0,1.529,0.184,2.188,0.549c0.658,0.367,1.178,0.867,1.563,1.5c0.383,0.635,0.574,1.342,0.574,2.125v0.65h-1.35v-0.625
                          c0-0.533-0.137-1.021-0.412-1.463c-0.275-0.441-0.643-0.791-1.1-1.049c-0.459-0.259-0.947-0.389-1.463-0.389
                          c-0.518,0-1.004,0.13-1.463,0.389c-0.459,0.258-0.824,0.607-1.1,1.049c-0.275,0.442-0.412,0.93-0.412,1.463v1.176
                          c0,0.916,0.295,1.583,0.887,2c0.592,0.416,1.379,0.741,2.363,0.975c1.1,0.25,2.049,0.696,2.85,1.337
                          c0.799,0.643,1.199,1.597,1.199,2.863v1.074c0,0.801-0.191,1.521-0.574,2.163c-0.385,0.642-0.904,1.138-1.563,1.487
                          s-1.389,0.525-2.188,0.525C79.133,51.659,78.404,51.483,77.746,51.134z"/>
                </svg>
            </a>
            {translate key="footer.nakladatelstvi"}<br />
            {translate key="footer.contact.adresa"} / <a href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;%6d%75%6e%69%70%72%65%73%73@%70%72%65%73%73%2e%6d%75%6e%69%2e%63%7a" target="_blank" title="munipress">munipress@press.muni.cz</a></a>
        </div>
        <div class="footer-light__links footer-right-block">
            <div class="footer-right">
                <div class="inline-block align-left">
                    <a href="{translate key='footer.muni.link'}" title="{translate key='footer.muni'}" target="_blank" class="footer-light__copyrights__img">
                        <svg version="1.1" id="Vrstva_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                             width="110px" height="50px" viewBox="0 0 145 50" enable-background="new 0 0 145 50" xml:space="preserve">
                            <path fill="#0000DC" d="M0.82,9.052h6.322v40.601H0.82V9.052z M7.375,9.052h2.146l3.944,40.601h-2.146L7.375,9.052z M17.64,9.052
                                  h2.146l-3.944,40.601h-2.146L17.64,9.052z M20.018,9.052h6.38v40.601h-6.38V9.052z M50.352,9.052v31.03
                                  c0,1.044,0.396,1.934,1.189,2.668c0.792,0.734,1.672,1.102,2.639,1.102c0.966,0,1.846-0.367,2.639-1.102
                                  c0.792-0.734,1.189-1.624,1.189-2.668V9.052h6.38v31.263c0,1.777-0.484,3.402-1.451,4.871c-0.967,1.471-2.232,2.639-3.798,3.51
                                  C57.573,49.564,55.92,50,54.18,50c-1.74,0-3.393-0.436-4.959-1.305c-1.566-0.871-2.833-2.039-3.799-3.51
                                  c-0.967-1.469-1.45-3.094-1.45-4.871V9.052H50.352z M90.43,9.052v40.601h-6.379V9.052H90.43z M92.865,9.052l6.033,40.601h-2.205
                                  L90.662,9.052H92.865z M105.51,9.052v40.601h-6.379V9.052H105.51z M132.131,47.391V11.314h-5.451V9.052h17.342v2.262h-5.51v36.077
                                  h5.51v2.262H126.68v-2.262H132.131z"/>
                        </svg>
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
</footer><!-- pkp_structure_footer_wrapper -->

</div><!-- pkp_structure_page -->

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}

</body>
</html>
