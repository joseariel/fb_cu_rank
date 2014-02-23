@FbCURank.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->       
                                                                 
	class Entities.MarionetteCollection extends Backbone.Collection
		perPage: 50
		
		whereCollection: (iterator, options) ->
			return new @constructor @where(iterator), options
			
		setInstancePropertiesFor: (options, args...) ->
			for key, val of _.pick(options, args...) 
				@[key] = val  
	
	class Entities.Collection extends Entities.MarionetteCollection   
					
	class Entities.SpreadsheetCollection extends Entities.MarionetteCollection

		sync: (method, entity, options = {}) ->                                     
			Backbone.tabletopSync(method, entity, options)