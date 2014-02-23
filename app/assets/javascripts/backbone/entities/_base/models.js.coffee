@FbCURank.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->       
  
	class Entities.Model extends Backbone.Model

	class Entities.MarionetteModel extends Backbone.Model     
		
		toJSON: (options) ->
			data = {}
			attrs = _.clone(@attributes) 
			
			# if the model has a paramRoot attribute, use it as the root element
			if options and options.includeParamRoot and @paramRoot  
				data[@paramRoot] = attrs
			else
				data = attrs
			
			data   
			
		interpolateParams: (base, attribute_names) ->
			newBase = base             
			for name in attribute_names      
				newBase = newBase.replace("#{name}=?", "#{name}=#{encodeURIComponent(@get(name))}") 

			newBase

		save: (data, options = {}) ->
			isNew = @isNew()
			
			_.defaults options,
				wait: true
				success: 	_.bind(@saveSuccess, @, isNew, options.collection)
				error:		_.bind(@saveError, @)
                
			@unset "_errors"
			super data, options
		
		saveSuccess: (isNew, collection) =>
			if isNew ## model is being created
				collection.add @ if collection
				collection.trigger "model:created", @ if collection
				@trigger "created", @
			else ## model is being updated
				collection ?= @collection ## if model has collection property defined, use that if no collection option exists
				collection.trigger "model:updated", @ if collection
				@trigger "updated", @   
		
		saveError: (model, xhr, options) =>
			## set errors directly on the model unless status returned was 500 or 404
			@set _errors: $.parseJSON(xhr.responseText)?.errors unless xhr.status is 500 or xhr.status is 404 
			
	class Entities.APIModel extends Entities.MarionetteModel  
		
		fetchResponse: (model, xhr, options) =>
			log "fetchResponse", @resultsRoot
			if xhr and xhr.query and xhr.query.results and xhr.query.results[@resultsRoot] and xhr.query.results[@resultsRoot].message and xhr.query.results[@resultsRoot].message.code
				statusCode = xhr.query.results[@resultsRoot].message.code
				if statusCode is "200" or statusCode is "0"
					@fetchSuccess(model, xhr, options)
				else     
					xhr.responseText = { errors: xhr.query.results[@resultsRoot].message.text }
					xhr.status = xhr.query.results[@resultsRoot].message.code
					@fetchError(model, xhr, options) 
			
		fetchSuccess: (model, xhr, options) => 
			log 'fetchSuccess', xhr                                    
			@trigger "fetched", @
			
		fetchError: (model, xhr, options) =>   
			log 'fetchError', xhr
			if xhr.status isnt 500 and xhr.status isnt 404 
				# set errors directly on the model unless status returned was 500 or 404 
				match = xhr.responseText.errors.match(/^Error\: (no exact match found for input) (.*)/)
				if match
					errors = {}
					errors[match[2]] = [ match[1] ]
					@set _errors: errors 
			
		fetch: (options = {}) ->
			_.defaults options,
				reset: true 
				wait: true
				success: 	_.bind(@fetchResponse, @)
				error:		_.bind(@fetchError, @)
				crossDomain: true
				url: @url()
				format: 'xml'
					
			@unset "_errors"
			super(options)
		
		
		