{**
* templates/header/sitenav.tpl
*
* Copyright (c) 2014 Simon Fraser University Library
* Copyright (c) 2003-2014 John Willinsky
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
*
* Site-Wide Navigation Bar
*}
<script type="text/javascript">
    <!--
                function changeLanguageCzEn() {ldelim}
                        var lang = document.getElementById('tlacitko');

                        var new_locale = lang.value;

                        var base_url = "{$currentUrl|escape}";
                        var current_url = document.URL;

                        var redirect_url = '{url|escape:"javascript" router=$smarty.const.ROUTE_PAGE page="user" op="setLocale" path="NEW_LOCALE" source=$smarty.server.REQUEST_URI}';
                        redirect_url = redirect_url.replace("NEW_LOCALE", new_locale);

                        window.location.href = redirect_url;
    {rdelim}
        //-->
</script>
{translate|assign:"langCzEn" key="jazyk.vyber"}
<div class="pkp_structure_head_siteNav">
    <div class="pkp_helpers_flatlist pkp_helpers_align_left zahlavi_munipress">
         <img src="{$baseUrl}/images/design/zahlavi_{if $langCzEn == "cs_CZ"}cz{else}en{/if}.png" alt="MUNIPRESS"/>
    </div>
    <div class="pkp_helpers_flatlist pkp_helpers_align_right">
        <table>
            <tbody>
                <tr>
            <form action="#">                        
                
                {if $langCzEn == "cs_CZ"}
                    <td>
                        <img src="{$baseUrl}/images/vlajky/cz_square_small_grey.png" style="float:left;"/>
                    </td><td>
                        <input id="tlacitko" type="submit" class="lang_cz_en_small en_small" value="en_US" onclick="changeLanguageCzEn();
                            return false;" />
                    </td>

                {else} 
                    <td>
                        <input id="tlacitko" type="button" class="lang_cz_en_small cz_small" value="cs_CZ" onclick="changeLanguageCzEn();
                            return false;"/>
                    </td><td>
                        <img src="{$baseUrl}/images/vlajky/en_square_small_grey.png" />
                    </td>
                {/if}                    
            </form>
            </tr>
            </tbody>
        </table>
    </div>
</div>
