{**
 * templates/controllers/grid/users/author/form/authorForm.tpl
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Submission Contributor grid form
 *
 *}

<script>
	// Attach the Information Center handler.
	$(function() {ldelim}
		$('#editAuthor').pkpHandler(
			'$.pkp.controllers.form.AjaxFormHandler'
		);
	{rdelim});
</script>

<form class="pkp_form" id="editAuthor" method="post" action="{url op="updateAuthor" authorId=$authorId}">
	{include file="controllers/notification/inPlaceNotification.tpl" notificationId="authorFormNotification"}

	{include
		file="common/userDetails.tpl"
		disableUserNameSection=true
		disableEmailWithConfirmSection=true
		disableAuthSourceSection=true
		disablePasswordSection=true
		disableSendNotifySection=true
		disableGenderSection=true
                disableSalutationSection=true
                disableSuffixSection=true
		disableInitialsSection=true
		disableLocaleSection=true
		disableInterestsSection=true
		disableMailingSection=true
                disableUCOSection=true
		disableSignatureSection=true
		extraContentSectionUnfolded=true
		countryRequired=true    
                disablePhoneSection=true
                disableFaxSection=true   
                disableUrlSection=true             
	}
        
        {********************
            MUNIPRESS
        **********************}
        {if $isUserLoggedIn }
            {fbvFormArea id="munipress" }
                    {fbvFormSection label="author.munipress"}
                         {fbvElement type="text" label="user.url" name="url" id="url" value=$url inline=true size=$fbvStyles.size.SMALL}
                    {/fbvFormSection}
                    {fbvFormSection}
                         {fbvElement type="text" label="author.munipress.titulyPred" name="tituly_pred" id="tituly_pred" value=$tituly_pred inline=true size=$fbvStyles.size.SMALL}
                         {fbvElement type="text" label="author.munipress.tituly_za" name="tituly_za" id="tituly_za" value=$tituly_za inline=true size=$fbvStyles.size.SMALL}
                    {/fbvFormSection}
                    
                    {fbvFormSection}
                         {fbvElement type="text" label="author.munipress.rodneCislo" name="rodne_cislo" id="rodne_cislo" value=$rodne_cislo inline=true size=$fbvStyles.size.SMALL}
                         {fbvElement type="text" label="author.munipress.mu" name="mu" id="mu" value=$mu inline=true size=$fbvStyles.size.SMALL}
			{fbvElement type="text" label="user.uco" name="uco" id="uco" value=$uco maxlength="24" inline=true size=$fbvStyles.size.SMALL}
                    {/fbvFormSection}	
                    
                    {fbvFormSection for="poznamka"}
                            {fbvElement type="textarea" label="author.munipress.poznamka" name="poznamka" id="poznamka" rich=true value=$poznamka inline=true size=$fbvStyles.size.LARGE}
                    {/fbvFormSection}
            {/fbvFormArea}
        {/if}
        {********************}

	{fbvFormArea id="submissionSpecific"}
		{fbvFormSection id="userGroupId" label="submission.submit.contributorRole" list=true}
			{iterate from=authorUserGroups item=userGroup}
				{if $userGroupId == $userGroup->getId()}{assign var="checked" value=true}{else}{assign var="checked" value=false}{/if}
				{fbvElement type="radio" id="userGroup"|concat:$userGroup->getId() name="userGroupId" value=$userGroup->getId() checked=$checked label=$userGroup->getLocalizedName() translate=false}
			{/iterate}
		{/fbvFormSection}
		{fbvFormSection list="true"}
			{fbvElement type="checkbox" label="submission.submit.selectPrincipalContact" id="primaryContact" checked=$primaryContact}
		{/fbvFormSection}
	{/fbvFormArea}

	{if $submissionId}
		<input type="hidden" name="submissionId" value="{$submissionId|escape}" />
	{/if}
	{if $gridId}
		<input type="hidden" name="gridId" value="{$gridId|escape}" />
	{/if}
	{if $rowId}
		<input type="hidden" name="rowId" value="{$rowId|escape}" />
	{/if}

	{fbvFormButtons id="step2Buttons" submitText="common.save"}
</form>
<p><span class="formRequired">{translate key="common.requiredField"}</span></p>
