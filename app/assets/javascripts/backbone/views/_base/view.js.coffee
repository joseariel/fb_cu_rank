@FbCURank.module "Views", (Views, App, Backbone, Marionette, $, _) ->  
	
	_.extend Marionette.View::,
     
		setInstancePropertiesFor: (args...) ->
			for key, val of _.pick(@options, args...)
				@[key] = val          
	
		templateHelpers: ->  
			
			# currentUser: 
			# 	App.request("get:current:user").toJSON()  
			# 	
			linkTo: (name, url, options = {}) ->    
				_.defaults options,
					external: false
					
				url = "#" + url unless options.external
				
				"<a href='#{url}'>#{@escape(name)}</a>"