@FbCURank = do (Backbone, Marionette) ->

	App = new Marionette.Application     
	
	App.rootRoute = Routes.root_path()  
	
	App.on "initialize:before", (options) ->
		App.environment = options.environment
		App.shortcuts()                   
		# @currentUser = App.request "set:current:user", options.currentUser
	            
	App.addRegions
		headerRegion: "#header-region"
		mainRegion: "#main-region"
		footerRegion: "#footer-region"
		
	App.addInitializer ->            	
		App.module("HeaderApp").start()
		# App.module("FooterApp").start()
	
	App.reqres.setHandler "default:region", ->
		App.mainRegion

	App.commands.setHandler "register:instance", (instance, id) ->
		App.register instance, id if App.environment is "development"

	App.commands.setHandler "unregister:instance", (instance, id) ->
		App.unregister instance, id if App.environment is "development"
       
	App.on "initialize:after", ->
		@startHistory()
		@navigate(@rootRoute, trigger: true) unless @getCurrentRoute()
	
	App.keys = 
		zillow: "X1-ZWz1dat0oaieq3_3if65"
	
	App.shortcuts = ->
		if App.environment is "development"
			window.log = ->
				console.info(arguments...)
			
	App   
	   
	
# http://designmodo.com/