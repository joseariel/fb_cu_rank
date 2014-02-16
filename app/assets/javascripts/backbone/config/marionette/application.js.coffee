do (Backbone) ->
	
	_.extend Backbone.Marionette.Application::,                   
	                  
		startHistory: ->
			if Backbone.history
				Backbone.history.start()
	       
		navigate: (route, options = {}) ->
			# route = "#" + route if route.charAt(0) is "/"
			Backbone.history.navigate route, options
		
		getCurrentRoute: -> 
			Backbone.history.fragment   
		
		getCurrentUrlPath: ->
			window.location.pathname
			           
		register: (instance, id) ->
			@_registry ?= {}
			@_registry[id] = instance

		unregister: (instance, id) ->
			delete @_registry[id]  
		
		resetRegistry: ->
			oldCount = @getRegistrySize()
			for key, controller of @_registry
				controller.region.close()
			msg = "There were #{oldCount} controllers in the registry, there are now #{@getRegistrySize()}"
			if @getRegistrySize() > 0 then console.warn(msg, @_registry) else console.log(msg)
		
		getRegistrySize: ->
			_.size @_registry