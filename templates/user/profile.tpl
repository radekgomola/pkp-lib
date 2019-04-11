{**
 * templates/user/profile.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User profile tabset.
 *}
{include file="common/header.tpl" pageTitle="user.profile"}

<script type="text/javascript">
	// Attach the JS file tab handler.
	$(function() {ldelim}
		$('#profileTabs').pkpHandler('$.pkp.controllers.TabHandler');
	{rdelim});
</script>
<div id="profileTabs" class="pkp_controllers_tab">
	<ul>
		<li><a name="identity" href="{url router=$smarty.const.ROUTE_COMPONENT component="tab.user.ProfileTabHandler" op="identity"}">{translate key="user.profile.identity"}</a></li>
		<li><a name="contact" href="{url router=$smarty.const.ROUTE_COMPONENT component="tab.user.ProfileTabHandler" op="contact"}">{translate key="user.profile.contact"}</a></li>
		{if array_intersect(array(ROLE_ID_MANAGER, ROLE_ID_SUB_EDITOR, ROLE_ID_ASSISTANT, ROLE_ID_REVIEWER), (array)$userRoles)}<li><a name="roles" href="{url router=$smarty.const.ROUTE_COMPONENT component="tab.user.ProfileTabHandler" op="roles"}">{translate key="user.roles"}</a></li>{/if}
		{if array_intersect(array(ROLE_ID_MANAGER, ROLE_ID_SUB_EDITOR, ROLE_ID_ASSISTANT, ROLE_ID_REVIEWER), (array)$userRoles)}<li><a name="publicProfile" href="{url router=$smarty.const.ROUTE_COMPONENT component="tab.user.ProfileTabHandler" op="publicProfile"}">{translate key="user.profile.public"}</a></li>{/if}
		<li><a name="changePassword" href="{url router=$smarty.const.ROUTE_COMPONENT component="tab.user.ProfileTabHandler" op="changePassword"}">{translate key="user.password"}</a></li>
		{if array_intersect(array(ROLE_ID_MANAGER, ROLE_ID_SUB_EDITOR, ROLE_ID_ASSISTANT, ROLE_ID_REVIEWER), (array)$userRoles)}<li><a name="notificationSettings" href="{url router=$smarty.const.ROUTE_COMPONENT component="tab.user.ProfileTabHandler" op="notificationSettings"}">{translate key="notification.notifications"}</a></li>{/if}
	</ul>
</div>

{include file="common/footer.tpl"}
