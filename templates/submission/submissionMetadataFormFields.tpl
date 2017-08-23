{**
* templates/submission/submissionMetadataFormFields.tpl
*
* Copyright (c) 2014-2017 Simon Fraser University
* Copyright (c) 2003-2017 John Willinsky
* Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
*
* Submission's metadata form fields. To be included in any form that wants to handle
* submission metadata.
*}

{*MUNIPRESS*}
{fbvFormArea id="verejneInformace" title="submission.informace.verejne" class="border"}
    {fbvFormSection for="a_kol" list=true}
        {if $a_kol}
            {assign var="checked" value=true}
        {else}
            {assign var="checked" value=false}
        {/if}

        {fbvElement type="checkbox" label="submission.a_kolektiv" checked=$checked name="a_kol" id="a_kol" translate="true"}
    {/fbvFormSection} 

    {fbvFormSection label="submission.ceny"}
            {fbvElement type="text" label="submission.ceny.kniha" name="cena" id="cena" value=$cena maxlength="40" inline=true size=$fbvStyles.size.SMALL}
            {fbvElement type="text" label="submission.ceny.ekniha" name="cena_ebook" id="cena_ebook" value=$cena_ebook inline=true maxlength="40" size=$fbvStyles.size.SMALL}
    {/fbvFormSection} 

    {fbvFormSection label="submission.metadata.url.munishop"}
        {fbvElement type="text" label="submission.metadata.url.munishop.kniha" name="urlMunishop" id="urlMunishop" value=$urlMunishop size=$fbvStyles.size.LARGE}
        {fbvElement type="text" label="submission.metadata.url.munishop.ekniha" name="urlMunishop_ebook" id="urlMunishop_ebook" value=$urlMunishop_ebook size=$fbvStyles.size.LARGE}
    {/fbvFormSection}

    {fbvFormSection title="submission.manazer.datumVydani"}
        <script>
                    $('input[id^="datumVydani"]').datepicker({ldelim}dateFormat: 'yy-mm-dd'{rdelim});
        </script>
        {fbvElement type="text" label="submission.manazer.datumVydani.description" id="datumVydani" name="datumVydani" value=$datumVydani|date_format:"%Y-%m-%d" inline=true size=$fbvStyles.size.MEDIUM}

    {/fbvFormSection} 

    {fbvFormSection label="submission.url.web" for="urlWeb"}
        {fbvElement type="text" name="urlWeb" multilingual="true" id="urlWeb" value=$urlWeb maxlength="255" readonly=$readOnly}
    {/fbvFormSection}
    {fbvFormSection title="submission.poznamka" for="poznamka" description="submission.poznamka.description"}
		{fbvElement type="textarea" multilingual=true name="poznamka" id="poznamka" value=$poznamka rich=true readonly=$readOnly}
    {/fbvFormSection}
{/fbvFormArea}
{fbvFormArea id="munipressInformace" title="submission.informace.munipress" class="border"}       
        
        {fbvFormSection for="archivace" list=true}
        {if $archivace}
		{assign var="checked" value=true}
        {else}
                {assign var="checked" value=false}
        {/if}
        
		{fbvElement type="checkbox" label="submission.archivace" checked=$checked name="archivace" id="archivace" translate="true"}
                <span class="sub_label">({translate key="submission.archivace.description"})</span>
                
        {/fbvFormSection} 
        
        {fbvFormSection title="submission.poznamka.admin"}
		{fbvElement type="textarea" name="poznamkaAdmin" id="poznamkaAdmin" value=$poznamkaAdmin rich=true}
	{/fbvFormSection}         
       
{/fbvFormArea}
{*---------------------*}

{if $coverageEnabled || $typeEnabled || $sourceEnabled || $rightsEnabled ||
		$languagesEnabled || $subjectEnabled || $keywordsEnabled || $agenciesEnabled || $referencesEnabled}
{fbvFormSection title="submission.metadata"}
<p class="description">{translate key="submission.metadataDescription"}</p>
{/fbvFormSection}
{/if}
    {if $coverageEnabled || $typeEnabled || $sourceEnabled || $rightsEnabled}
        {fbvFormArea id="additionalDublinCore"}
        {if $coverageEnabled}
            {fbvFormSection title="submission.coverage" for="coverage"}
            {fbvElement type="text" multilingual=true name="coverage" id="coverage" value=$coverage maxlength="255" readonly=$readOnly}
            {/fbvFormSection}
        {/if}
        {if $typeEnabled}
            {fbvFormSection for="type" title="common.type"}
            {fbvElement type="text" label="submission.type.tip" multilingual=true name="type" id="type" value=$type maxlength="255" readonly=$readOnly}
            {/fbvFormSection}
        {/if}
        {if $sourceEnabled}
            {fbvFormSection label="submission.source" for="source"}
            {fbvElement type="text" label="submission.source.tip" multilingual=true name="source" id="source" value=$source maxlength="255" readonly=$readOnly}
            {/fbvFormSection}
        {/if}
        {if $rightsEnabled}
            {fbvFormSection label="submission.rights" for="rights"}
            {fbvElement type="text" label="submission.rights.tip" multilingual=true name="rights" id="rights" value=$rights maxlength="255" readonly=$readOnly}
            {/fbvFormSection}
        {/if}
        {/fbvFormArea}
    {/if}

    {if $languagesEnabled || $subjectEnabled || $keywordsEnabled || $agenciesEnabled || $referencesEnabled || $disciplinesEnabled}
        {fbvFormArea id="tagitFields" title="submission.submit.metadataForm"}
        {if $languagesEnabled}
            {$languagesField}
        {/if}
        {if $subjectEnabled}
            {fbvFormSection label="common.subjects"}
            {fbvElement type="keyword" id="subjects" multilingual=true current=$subjects disabled=$readOnly}
            {/fbvFormSection}
        {/if}
        {if $disciplinesEnabled}
            {fbvFormSection label="search.discipline"}
            {fbvElement type="keyword" id="disciplines" multilingual=true current=$disciplines disabled=$readOnly}
            {/fbvFormSection}
        {/if}
        {if $keywordsEnabled}
            {fbvFormSection label="common.keywords"}
            {fbvElement type="keyword" id="keywords" multilingual=true current=$keywords disabled=$readOnly}
            {/fbvFormSection}
        {/if}
        {if $agenciesEnabled}
            {fbvFormSection label="submission.supportingAgencies"}
            {fbvElement type="keyword" id="agencies" multilingual=true current=$agencies disabled=$readOnly}
            {/fbvFormSection}
        {/if}
        {if $referencesEnabled}
            {fbvFormSection label="submission.citations"}
            {fbvElement type="textarea" id="citations" value=$citations disabled=$readOnly}
            {/fbvFormSection}
        {/if}
        {/fbvFormArea}
    {/if}

    {call_hook name="Templates::Submission::SubmissionMetadataForm::AdditionalMetadata"}
