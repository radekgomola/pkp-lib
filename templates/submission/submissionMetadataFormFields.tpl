{**
 * submission/submissionMetadataFormFields.tpl
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Submission's metadata form fields. To be included in any form that wants to handle
 * submission metadata.
 *}
{*{if $submissionSettings.all || $submissionSettings.metaCoverage}
	{fbvFormArea id="coverageInformation" title="submission.coverage" class="border"}
		{fbvFormSection title="submission.coverage.chron" for="coverageChron" description="submission.coverage.tip"}
			{fbvElement type="text" multilingual=true name="coverageChron" id="coverageChron" value=$coverageChron maxlength="255" readonly=$readOnly}
		{/fbvFormSection}
		{fbvFormSection title="submission.coverage.geo" for="coverageGeo"}
			{fbvElement type="text" multilingual=true name="coverageGeo" id="coverageGeo" value=$coverageGeo maxlength="255" readonly=$readOnly}
		{/fbvFormSection}
		{fbvFormSection title="submission.coverage.sample" for="coverageSample"}
			{fbvElement type="text" multilingual=true name="coverageSample" id="coverageSample" value=$coverageSample maxlength="255" readonly=$readOnly}
		{/fbvFormSection}
	{/fbvFormArea}
{/if}*}


{*{fbvFormArea id="additionalDublinCore" title="common.type" class="border"}
	{if $submissionSettings.all || $submissionSettings.metaType}
		{fbvFormSection for="type" title="common.type" description="submission.type.tip"}
			{fbvElement type="text" multilingual=true name="type" id="type" value=$type maxlength="255" readonly=$readOnly}
		{/fbvFormSection}
	{/if}
	{if $submissionSettings.all || $submissionSettings.metaSubjectClass}
		{fbvFormSection label="submission.subjectClass" for="subjectClass" description="submission.subjectClass.tip"}
			{fbvElement type="text" multilingual=true name="subjectClass" id="subjectClass" value=$subjectClass maxlength="255" readonly=$readOnly}
		{/fbvFormSection}
	{/if}
	{fbvFormSection label="submission.source" for="source" description="submission.source.tip"}
		{fbvElement type="text" multilingual=true name="source" id="source" value=$source maxlength="255" readonly=$readOnly}
	{/fbvFormSection}*}
        
	{*{fbvFormSection label="submission.rights" for="rights" description="submission.rights.tip"}
		{fbvElement type="text" multilingual=true name="rights" id="rights" value=$rights maxlength="255" readonly=$readOnly}
	{/fbvFormSection}*}

{*{fbvFormArea id="tagitFields" title="submission.submit.metadataForm" class="border"}
	{fbvFormSection description="submission.submit.metadataForm.tip" title="common.languages"}
		{url|assign:languagesSourceUrl router=$smarty.const.ROUTE_PAGE page="submission" op="fetchChoices" codeList="74"}
		{fbvElement type="keyword" id="languages" subLabelTranslate=true multilingual=true current=$languages source=$languagesSourceUrl disabled=$readOnly}
	{/fbvFormSection}
	{if $submissionSettings.all}
		{fbvFormSection label="common.subjects"}
			{fbvElement type="keyword" id="subjects" subLabelTranslate=true multilingual=true current=$subjects disabled=$readOnly}
		{/fbvFormSection}
	{/if}
	{if $submissionSettings.all || $submissionSettings.metaDiscipline}
		{fbvFormSection label="search.discipline"}
			{fbvElement type="keyword" id="disciplines" subLabelTranslate=true multilingual=true current=$disciplines disabled=$readOnly}
		{/fbvFormSection}
	{/if}
	{fbvFormSection label="common.keywords"}
		{fbvElement type="keyword" id="keyword" subLabelTranslate=true multilingual=true current=$keywords disabled=$readOnly}
	{/fbvFormSection}
	{fbvFormSection label="submission.supportingAgencies"}
		{fbvElement type="keyword" id="agencies" multilingual=true subLabelTranslate=true current=$agencies disabled=$readOnly}
	{/fbvFormSection}
{/fbvFormArea}*}

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
        
        {fbvFormSection label="submission.metadata.url.oc"}
		{fbvElement type="text" label="submission.metadata.url.oc.kniha" name="urlOC" id="urlOC" value=$urlOC maxlength="50" inline=true size=$fbvStyles.size.SMALL}
                {fbvElement type="text" label="submission.metadata.url.oc.ekniha" name="urlOC_ebook" id="urlOC_ebook" value=$urlOC_ebook maxlength="50" inline=true size=$fbvStyles.size.SMALL}
        {/fbvFormSection}
        
        {fbvFormSection title="submission.manazer.datumVydani"}
                <script>
                    $('input[id^="datumVydani"]').datepicker({ldelim} dateFormat: 'yy-mm-dd' {rdelim});
                </script>
                {fbvElement type="text" label="submission.manazer.datumVydani.description" id="datumVydani" name="datumVydani" value=$datumVydani|date_format:"%Y-%m-%d" inline=true size=$fbvStyles.size.MEDIUM}
                
	{/fbvFormSection} 
        
        {fbvFormSection label="submission.url.web" for="urlWeb"}
		{fbvElement type="text" name="urlWeb" multilingual="true" id="urlWeb" value=$urlWeb maxlength="255" readonly=$readOnly}
	{/fbvFormSection}
            
        {*{fbvFormSection label="submission.souvisejiciPublikace" description="submission.submit.metadataForm.tip"}
                {fbvElement type="keyword" name="souvisejiciPublikace" id="souvisejiciPublikace" current=$souvisejiciPublikace maxlength="500"}
        {/fbvFormSection} *}
        
        {fbvFormSection label="submission.klicovaSlova" description="submission.submit.metadataForm.tip"}
		{fbvElement type="keyword" id="keyword" multilingual=true current=$keywords size=$fbvStyles.size.BIG}
	{/fbvFormSection}
        
        {fbvFormSection  label="submission.jazyky" description="submission.jazyky.description"}
		{url|assign:languagesSourceUrl router=$smarty.const.ROUTE_PAGE page="submission" op="fetchChoices" codeList="74"}
		{fbvElement type="keyword" id="languages" subLabelTranslate=true multilingual=true current=$languages source=$languagesSourceUrl}
        {/fbvFormSection}
        {fbvFormSection title="submission.poznamka" for="poznamka" description="submission.poznamka.description"}
		{fbvElement type="textarea" multilingual=true name="poznamka" id="poznamka" value=$poznamka rich=true readonly=$readOnly}
	{/fbvFormSection}
        {fbvFormSection title="submission.dedikace" for="dedikace"}
		{fbvElement type="textarea" multilingual=true name="dedikace" id="dedikace" value=$dedikace rich=true readonly=$readOnly}
	{/fbvFormSection}        
 {/fbvFormArea}
       
 {*        Tady jsou metadata pro munipress*}
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
         
        {fbvFormSection label="submission.muPracoviste"}
                {fbvElement type="text" name="muPracoviste" id="muPracoviste" value=$muPracoviste inline=true size=$fbvStyles.size.MEDIUM}
	{/fbvFormSection}
        
        {fbvFormSection title="submission.poznamka.admin"}
		{fbvElement type="textarea" name="poznamkaAdmin" id="poznamkaAdmin" value=$poznamkaAdmin rich=true}
	{/fbvFormSection}         
       
{/fbvFormArea}
