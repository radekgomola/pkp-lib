/**
 * @defgroup js_controllers
 */
/**
 * @file js/controllers/SiteHandler.js
 *
 * Copyright (c) 2014 Simon Fraser University Library
 * Copyright (c) 2000-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class SiteHandler
 * @ingroup js_controllers
 *
 * @brief Handle the site widget.
 */
(function($) {


	/**
	 * @constructor
	 *
	 * @extends $.pkp.classes.Handler
	 *
	 * @param {jQueryObject} $widgetWrapper An HTML element that this handle will
	 * be attached to.
	 * @param {{
	 *   toggleHelpUrl: string,
	 *   toggleHelpOffText: string,
	 *   toggleHelpOnText: string,
	 *   fetchNotificationUrl: string,
	 *   requestOptions: Object
	 *   }} options Handler options.
	 */
	$.pkp.controllers.SiteHandler = function($widgetWrapper, options) {
		this.parent($widgetWrapper, options);

		this.options_ = options;
		this.unsavedFormElements_ = [];

		$('.go').button();

		this.bind('redirectRequested', this.redirectToUrl);
		this.bind('notifyUser', this.fetchNotificationHandler_);
		this.bind('updateHeader', this.updateHeaderHandler_);
		this.bind('updateSidebar', this.updateSidebarHandler_);
		this.bind('callWhenClickOutside', this.callWhenClickOutsideHandler_);
		this.bind('mousedown', this.mouseDownHandler_);
		this.bind('urlInDivLoaded', this.setMainMaxWidth_);

		// Listen for grid initialized events so the inline help
		// can be shown or hidden.
		this.bind('gridInitialized', this.updateHelpDisplayHandler_);

		// Listen for help toggle events.
		this.bind('toggleInlineHelp', this.toggleInlineHelpHandler_);

		// Bind the pageUnloadHandler_ method to the DOM so it is
		// called.
		$(window).bind('beforeunload', this.pageUnloadHandler_);

		// Avoid IE8 caching ajax results. If it does, widgets like
		// grids will not refresh correctly.
		$.ajaxSetup({cache: false});

		$('select.applyPlugin', $widgetWrapper).selectBox();

		// Check if we have notifications to show.
		if (options.hasSystemNotifications) {
			this.trigger('notifyUser');
		}

		// bind event handlers for form status change events.
		this.bind('formChanged', this.callbackWrapper(
				this.registerUnsavedFormElement_));
		this.bind('unregisterChangedForm', this.callbackWrapper(
				this.unregisterUnsavedFormElement_));
		this.bind('modalCanceled', this.callbackWrapper(
				this.unregisterUnsavedFormElement_));
		this.bind('unregisterAllForms', this.callbackWrapper(
				this.unregisterAllFormElements_));

		this.outsideClickChecks_ = {};
	};
	$.pkp.classes.Helper.inherits(
			$.pkp.controllers.SiteHandler, $.pkp.classes.Handler);


	//
	// Private properties
	//
	/**
	 * Site handler options.
	 * @private
	 * @type {Object}
	 */
	$.pkp.controllers.SiteHandler.prototype.options_ = null;


	/**
	 * Object with data to be used when checking if user
	 * clicked outside a site element. See callWhenClickOutsideHandler_()
	 * to check the expected check options.
	 * @private
	 * @type {Object}
	 */
	$.pkp.controllers.SiteHandler.prototype.outsideClickChecks_ = null;


	/**
	 * A state variable to store the form elements that have unsaved data.
	 * @private
	 * @type {Array}
	 */
	$.pkp.controllers.SiteHandler.prototype.unsavedFormElements_ = null;


	//
	// Public static methods.
	//
	/**
	 * Callback used by the tinyMCE plugin to trigger the tinyMCEInitialized
	 * event in the DOM.
	 * @param {Object} tinyMCEObject The tinyMCE object instance being
	 * initialized.
	 */
	$.pkp.controllers.SiteHandler.prototype.triggerTinyMCEInitialized =
			function(tinyMCEObject) {
		var $inputElement = $('#' + tinyMCEObject.editorId);
		$inputElement.trigger('tinyMCEInitialized', [tinyMCEObject]);
	};


	/**
	 * Callback used by the tinyMCE plugin upon setup.
	 * @param {Object} tinyMCEObject The tinyMCE object instance being
	 * set up.
	 */
	$.pkp.controllers.SiteHandler.prototype.triggerTinyMCESetup =
			function(tinyMCEObject) {

		// For read-only controls, set up TinyMCE read-only mode.
		if ($('#' + tinyMCEObject.id).attr('readonly')) {
			tinyMCEObject.settings.readonly = true;
		}

		// Add a fake HTML5 placeholder when the editor is intitialized
		tinyMCEObject.onInit.add(function(tinyMCEObject) {
			var $element = $('#' + tinyMCEObject.id),
					placeholderText,
					$placeholder,
					$placeholderParent;

			// Don't add anything if we don't have a placeholder
			placeholderText = $('#' + tinyMCEObject.id).attr('placeholder');
			if (placeholderText === '') {
				return;
			}

			// Create placeholder element
			$placeholder = /** @type {jQueryObject} */ ($('<span></span>')
					.html(/** @type {string} */ (placeholderText)));
			$placeholder.addClass('mcePlaceholder');
			$placeholder.attr('id', 'mcePlaceholder-' + tinyMCEObject.id);
			if (tinyMCEObject.getContent().length) {
				$placeholder.hide();
			}

			// Create placeholder wrapper
			$placeholderParent = $('<div></div>');
			$placeholderParent.addClass('mcePlaceholderParent');
			$element.wrap($placeholderParent);
			$element.parent().append($placeholder);
		});

		tinyMCEObject.onActivate.add(function(tinyMCEObject) {
			// Hide the placeholder when the editor is activated
			$('#mcePlaceholder-' + tinyMCEObject.id).hide();
		});

		tinyMCEObject.onDeactivate.add(function(tinyMCEObject) {
			// Show the placholder when the editor is deactivated
			if (!tinyMCEObject.getContent().length) {
				$('#mcePlaceholder-' + tinyMCEObject.id).show();
			}

			tinyMCEObject.dom.addClass(tinyMCEObject.dom.select('li'), 'show');
		});
	};


	//
	// Public methods
	//
	/**
	 * Callback that is triggered when the page should redirect.
	 *
	 * @param {HTMLElement} sourceElement The element that issued the
	 *  "redirectRequested" event.
	 * @param {Event} event The "redirect requested" event.
	 * @param {string} url The URL to redirect to.
	 */
	$.pkp.controllers.SiteHandler.prototype.redirectToUrl =
			function(sourceElement, event, url) {

		window.location = url;
	};


	/**
	 * Handler bound to 'formChanged' events propagated by forms
	 * that wish to have their form data tracked.
	 * @private
	 * @param {HTMLElement} siteHandlerElement The html element
	 * attached to this handler.
	 * @param {HTMLElement} sourceElement The element wishes to
	 * register.
	 * @param {Event} event The formChanged event.
	 */
	$.pkp.controllers.SiteHandler.prototype.registerUnsavedFormElement_ =
			function(siteHandlerElement, sourceElement, event) {
		var $formElement, formId, index;

		$formElement = $(event.target.lastElementChild);
		formId = $formElement.attr('id');
		index = $.inArray(formId, this.unsavedFormElements_);
		if (index == -1) {
			this.unsavedFormElements_.push(formId);
		}
	};


	/**
	 * Handler bound to 'unregisterChangedForm' events propagated by forms
	 * that wish to inform that they no longer wish to be tracked as 'unsaved'.
	 * @private
	 * @param {HTMLElement} siteHandlerElement The html element
	 * attached to this handler.
	 * @param {HTMLElement} sourceElement The element that wishes to
	 * unregister.
	 * @param {Event} event The unregisterChangedForm event.
	 */
	$.pkp.controllers.SiteHandler.prototype.unregisterUnsavedFormElement_ =
			function(siteHandlerElement, sourceElement, event) {
		var $formElement, formId, index;

		$formElement = $(event.target.lastElementChild);
		formId = $formElement.attr('id');
		index = $.inArray(formId, this.unsavedFormElements_);
		if (index !== -1) {
			delete this.unsavedFormElements_[index];
		}
	};


	/**
	 * Unregister all unsaved form elements.
	 * @private
	 */
	$.pkp.controllers.SiteHandler.prototype.unregisterAllFormElements_ =
			function() {
		this.unsavedFormElements_ = [];
	};


	//
	// Private methods.
	//
	/**
	 * Respond to a user toggling the display of inline help.
	 * @private
	 * @param {HTMLElement} sourceElement The element that
	 *  issued the event.
	 * @param {Event} event The triggering event.
	 * @return {boolean} Always returns false.
	 */
	$.pkp.controllers.SiteHandler.prototype.toggleInlineHelpHandler_ =
			function(sourceElement, event) {

		// persist the change on the server.
		$.ajax({url: this.options_.toggleHelpUrl});

		this.options_.inlineHelpState = this.options_.inlineHelpState ? 0 : 1;
		this.updateHelpDisplayHandler_();

		// Stop further event processing
		return false;
	};


	/**
	 * Callback to listen to grid initialization events. Used to
	 * toggle the inline help display on them.
	 * @private
	 * @param {HTMLElement=} opt_sourceElement The element that issued the
	 *  "gridInitialized" event.
	 * @param {Event=} opt_event The "gridInitialized" event.
	 */
	$.pkp.controllers.SiteHandler.prototype.updateHelpDisplayHandler_ =
			function(opt_sourceElement, opt_event) {
		var $bodyElement, inlineHelpState;

		$bodyElement = this.getHtmlElement();
		inlineHelpState = this.options_.inlineHelpState;
		if (inlineHelpState) {
			// the .css() call removes the CSS applied to the legend intially,
			// so it is not shown while the page is being loaded.
			$bodyElement.find('.pkp_grid_description, #legend, .pkp_help').
					css('visibility', 'visible').show();
			$bodyElement.find('[id^="toggleHelp"]').html(
					this.options_.toggleHelpOffText);
		} else {
			$bodyElement.find('.pkp_grid_description, #legend, .pkp_help').hide();
			$bodyElement.find('[id^="toggleHelp"]').html(
					this.options_.toggleHelpOnText);
		}
	};


	/**
	 * Fetch the notification data.
	 * @private
	 * @param {HTMLElement} sourceElement The element that issued the
	 *  "fetchNotification" event.
	 * @param {Event} event The "fetch notification" event.
	 * @param {Object} jsonData The JSON content representing the
	 *  notification.
	 */
	$.pkp.controllers.SiteHandler.prototype.fetchNotificationHandler_ =
			function(sourceElement, event, jsonData) {

		if (jsonData !== undefined) {
			// This is an event that came from an inplace notification
			// widget that was not visible because of the scrolling.
			this.showNotification_(jsonData);
			return;
		}

		// Avoid race conditions with in place notifications.
		$.ajax({
			url: this.options_.fetchNotificationUrl,
			data: this.options_.requestOptions,
			success: this.callbackWrapper(this.showNotificationResponseHandler_),
			dataType: 'json',
			async: false
		});
	};


	/**
	 * Fetch the header (e.g. on header configuration change).
	 * @private
	 * @param {HTMLElement} sourceElement The element that issued the
	 *  update header event.
	 * @param {Event} event The "fetch header" event.
	 */
	$.pkp.controllers.SiteHandler.prototype.updateHeaderHandler_ =
			function(sourceElement, event) {
		var handler = $.pkp.classes.Handler.getHandler($('#headerContainer'));
		handler.reload();
	};


	/**
	 * Fetch the sidebar (e.g. on sidebar configuration change).
	 * @param {HTMLElement} sourceElement The element that issued the
	 *  update sidebar event.
	 * @param {Event} event The "fetch sidebar" event.
	 * @private
	 */
	$.pkp.controllers.SiteHandler.prototype.updateSidebarHandler_ =
			function(sourceElement, event) {
		var handler = $.pkp.classes.Handler.getHandler($('#sidebarContainer'));
		handler.reload();
	};


	/**
	 * Call when click outside event handler. Stores the event
	 * parameters as checks to be used later by mouse down handler so we
	 * can track if user clicked outside the passed element or not.
	 * @private
	 * @param {HTMLElement} sourceElement The element that issued the
	 *  callWhenClickOutside event.
	 * @param {Event} event The "call when click outside" event.
	 * @param {{
	 *   container: jQueryObject,
	 *   callback: Function,
	 *   skipWhenVisibleModals: boolean
	 *   }} eventParams The event parameters.
	 * - container: a jQuery element to be used to test if user click
	 * outside of it or not.
	 * - callback: a callback function in case test is true.
	 * - skipWhenVisibleModals: boolean flag to tell whether skip the
	 * callback when modals are visible or not.
	 */
	$.pkp.controllers.SiteHandler.prototype.callWhenClickOutsideHandler_ =
			function(sourceElement, event, eventParams) {
		// Check the required parameters.
		if (eventParams.container === undefined) {
			return;
		}

		if (eventParams.callback === undefined) {
			return;
		}

		var id = eventParams.container.attr('id');
		this.outsideClickChecks_[id] = eventParams;
	};


	/**
	 * Mouse down event handler attached to the site element.
	 * @private
	 * @param {HTMLElement} sourceElement The element that issued the
	 *  click event.
	 * @param {Event} event The "mousedown" event.
	 * @return {?boolean} Event handling status.
	 */
	$.pkp.controllers.SiteHandler.prototype.mouseDownHandler_ =
			function(sourceElement, event) {

		var $container, callback, id;
		if (!$.isEmptyObject(this.outsideClickChecks_)) {
			for (id in this.outsideClickChecks_) {
				this.processOutsideClickCheck_(
						this.outsideClickChecks_[id], event);
			}
		}

		return true;
	};


	/**
	 * Check if the passed event target is outside the element
	 * inside the passed check data. If true and no other check
	 * option avoids it, use the callback.
	 * @private
	 * @param {{
	 *   skipWhenVisibleModals: boolean,
	 *   container: Object,
	 *   callback: Function
	 *   }} checkOptions Object with data to be used to
	 * check the click.
	 * @param {Event} event The click event to be checked.
	 * @return {boolean} Whether the check was processed or not.
	 */
	$.pkp.controllers.SiteHandler.prototype.processOutsideClickCheck_ =
			function(checkOptions, event) {

		// Make sure we have a click event.
		if (event.type !== 'click' &&
				event.type !== 'mousedown' && event.type !== 'mouseup') {
			throw new Error('Can not check outside click with the passed event: ' +
					event.type + '.');
		}

		// Get the container element.
		var $container = checkOptions.container;

		// Doesn't make sense to check an outside click
		// with an invisible element, so skip test if
		// container is hidden.
		if ($container.is(':hidden')) {
			return false;
		}

		// Check for the visible modals option.
		if (checkOptions.skipWhenVisibleModals !==
				undefined) {
			if (checkOptions.skipWhenVisibleModals) {
				if (this.getHtmlElement().find('div.ui-dialog').length > 0) {
					// Found a modal, return.
					return false;
				}
			}
		}

		// Do the click origin checking.
		if ($container.has(event.target).length === 0) {

			// Once the check was processed, delete it.
			delete this.outsideClickChecks_[$container.attr('id')];

			checkOptions.callback();

			return true;
		}

		return false;
	};


	/**
	 * Internal callback called upon page unload. If it returns
	 * anything other than void, a message will be displayed to
	 * the user.
	 * @private
	 * @param {Object} object The window object.
	 * @param {Event} event The before unload event.
	 * @return {string|undefined} The warning message string, if needed.
	 */
	$.pkp.controllers.SiteHandler.prototype.pageUnloadHandler_ =
			function(object, event) {
		var handler, unsavedElementCount, element;

		// any registered and then unregistered forms will exist
		// as properties in the unsavedFormElements_ object. They
		// will just be undefined.  See if there are any that are
		// not.

		// we need to get the handler this way since this event is bound
		// to window, not to SiteHandler.
		handler = $.pkp.classes.Handler.getHandler($('body'));

		unsavedElementCount = 0;
		for (element in handler.unsavedFormElements_) {
			if (element) {
				unsavedElementCount++;
			}
		}
		if (unsavedElementCount > 0) {
			return $.pkp.locale.form_dataHasChanged;
		}
		return undefined;
	};


	/**
	 * Method to determine if a form is currently registered as having
	 * unsaved changes.
	 *
	 * @param {string} id the id of the form to check.
	 * @return {boolean} true if the form is unsaved.
	 */
	$.pkp.controllers.SiteHandler.prototype.isFormUnsaved =
			function(id) {

		if (this.unsavedFormElements_ !== null &&
				this.unsavedFormElements_[id] !== undefined) {
			return true;
		}
		return false;
	};


	/**
	 * Response handler to the notification fetch.
	 * @private
	 * @param {Object} ajaxContext The data returned from the server.
	 * @param {Object} jsonData A parsed JSON response object.
	 */
	$.pkp.controllers.SiteHandler.prototype.showNotificationResponseHandler_ =
			function(ajaxContext, jsonData) {
		this.showNotification_(jsonData);
	};


	/**
	 * Show the notification content.
	 * @private
	 * @param {Object} jsonData The JSON-encoded notification data.
	 */
	$.pkp.controllers.SiteHandler.prototype.showNotification_ =
			function(jsonData) {
		var workingJsonData, notificationsData, levelId, notificationId;

		workingJsonData = this.handleJson(jsonData);
		if (workingJsonData !== false) {
			if (workingJsonData.content.general) {
				notificationsData = workingJsonData.content.general;
				for (levelId in notificationsData) {
					for (notificationId in notificationsData[levelId]) {
						// Hmm, this cast shouldn't be necessary but buildjs thinks so.
						/** @type {jQueryObject} */ ($).pnotify(
								notificationsData[levelId][notificationId]);
					}
				}
			}
		}
	};


	/**
	 * Set the maximum width for the pkp_structure_main div.
	 * This will prevent content with larger widths (like photos)
	 * messing up with layout.
	 * @private
	 * @param {HTMLElement} sourceElement The element that
	 *  issued the event.
	 * @param {Event} event The triggering event.
	 * @param {?string} data additional event data.
	 */
	$.pkp.controllers.SiteHandler.prototype.setMainMaxWidth_ =
			function(sourceElement, event, data) {

		var $site = this.getHtmlElement(), structureContentWidth, leftSideBarWidth,
				rightSideBarWidth, $mainDiv = $('.pkp_structure_main', $site),
				mainExtraWidth, mainMaxWidth, lastTabOffset, tabsContainerOffset,
				$lastTab, $allTabs = $mainDiv.find('.ui-tabs').tabs();

		if (data == 'sidebarContainer') {
			structureContentWidth = $('.pkp_structure_content', $site).width();

			leftSideBarWidth = $('.pkp_structure_sidebar_left', $site).
					outerWidth(true);
			rightSideBarWidth = $('.pkp_structure_sidebar_right', $site).
					outerWidth(true);

			// Check for padding, margin or border.
			mainExtraWidth = $mainDiv.outerWidth(true) - $mainDiv.width();
			mainMaxWidth = structureContentWidth - (
					leftSideBarWidth + rightSideBarWidth + mainExtraWidth);

			$mainDiv.css('max-width', mainMaxWidth);

			if ($mainDiv.find('.stTabsInnerWrapper').length == 1) {
				$mainDiv.find('.stTabsMainWrapper').width($mainDiv.outerWidth(true));
				tabsContainerOffset = $mainDiv.find('.ui-tabs-nav').offset().left +
						$mainDiv.find('.ui-tabs-nav').outerWidth(true);
				$lastTab = $mainDiv.find('.ui-tabs-nav').find('li').last();
				lastTabOffset = $lastTab.offset().left + $lastTab.outerWidth(true);
				if (lastTabOffset <= tabsContainerOffset) {
					$mainDiv.find('.stTabsMainWrapper').find('div').first().hide();
				} else {
					$mainDiv.find('.stTabsMainWrapper').find('div').first().show();
				}
			}
		}
	};


/** @param {jQuery} $ jQuery closure. */
}(jQuery));
