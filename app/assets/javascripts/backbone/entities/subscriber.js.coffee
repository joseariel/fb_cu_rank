@FbCURank.module "Entities", (Entities, App, Backbone, Marionette, $, _) -> 
  
	class Entities.Subscriber extends Backbone.Model
	  
		urlRoot: "https://us1.api.mailchimp.com/2.0/lists/subscribe.json"
		url: (data) ->
			base = _.result(@, 'urlRoot') or @urlError()
			
			finalUrl = base 
			finalUrl += "?apikey=#{@get('apikey')}"
			finalUrl += "&id=#{@get('id')}" 
			finalUrl += "&email=#{encodeURIComponent(JSON.stringify({ email: data.email }))}" 
			finalUrl += "&merge_vars=#{encodeURIComponent(@merge_vars(data))}" 
			finalUrl += "&format=json"
			                                            
			log finalUrl   
			finalUrl
	         
		save: (data, options = {}) ->
			@unset "_errors"        
			
			Parse.Cloud.run 'subscribe', data, 
				{
					success: _.bind(@saveResponse, @)
					error: _.bind(@saveResponse, @) 
				}
		
		saveResponse: (response) =>
			if typeof(response) is 'object'
				@saveErrors(response)
			else
				@saveSuccess()
		
		saveSuccess: =>
			@trigger "subscribed", @   
		
		saveErrors: (errors) =>                                                      
			@set _errors: errors 
		                                   
		# sync: (method, entity, options = {}) =>
		# 	_.defaults options,
		# 		beforeSend: _.bind((-> @trigger("sync:start", @)), 	entity)
		# 		complete:		_.bind((-> @trigger("sync:stop", @)),		entity)
		# 		includeParamRoot: true
		# 		crossDomain: true  
		# 		format: 'json'
		#                  
		# 	sync = if options.crossDomain is true
		# 		Backbone.crossdomainSync(method, entity, options)
		# 	else
		# 		Backbone.sync(method, entity, options)
		# 
		# 	if !entity._fetch and method is "read"
		# 		entity._fetch = sync
		# 
		# Backbone.crossdomainSync = (method, entity, options = {}) ->
		# 	$.requestCrossDomain(Backbone.sync, method, entity, options)
		
	API =
		newSubscriber: ->
			new Entities.Subscriber

	App.reqres.setHandler "subscriber:entity", ->
		API.newSubscriber()