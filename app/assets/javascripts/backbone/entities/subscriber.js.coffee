@FbCURank.module "Entities", (Entities, App, Backbone, Marionette, $, _) -> 
  
	class Entities.Subscriber extends Backbone.Model
	  
		initialize: ->
			@set('apikey', 'ad25fa8f7c21a4f3f31437e8534cb354-us7')
			@set('id', '19bfcb7675')
	 
		url: "https://us1.api.mailchimp.com/2.0/lists/subscribe.json"
	
		fetchResponse: (model, xhr, options) =>
			log "fetchResponse", xhr 
			
		fetch: (options = {}) ->
			_.defaults options,
				reset: true 
				wait: true
				success: 	_.bind(@fetchResponse, @)
				error:		_.bind(@fetchError, @)
				crossDomain: true
				async: false
				contentType: "application/json"
				dataType: 'jsonp'
				url: @url()

			@unset "_errors"
			super(options)
		
	API =
		newSubscriber: ->
			new Entities.Subscriber

	App.reqres.setHandler "subscriber:entity", ->
		API.newSubscriber()