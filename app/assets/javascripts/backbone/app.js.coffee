@FbCURank = do (Backbone, Marionette, $) ->

	App = new Marionette.Application     
	
	App.rootRoute = Routes.root  
	
	App.on "initialize:before", (options) ->
		App.environment = options.environment
		App.initializeParse();
		App.shortcuts()                   
		# @currentUser = App.request "set:current:user", options.currentUser
	
	App.initializeParse = -> 
		Parse.$ = $;
		Parse.initialize("AZhT0ksZdBwraEcjJ2RlFpefTX9U5GAw3oBGxUsJ", "BSvNRuRsQUflASUk3DKNO0iMV2fFeYODivz6m1VI"); 
	            
	App.addRegions
		headerRegion: "#header-region"
		mainRegion: "#main-region"
		footerRegion: "#footer-region"   
		modalRegion: Marionette.Region.Modal.extend el: "#modal-region"
		
	App.addInitializer ->            	
		App.module("HeaderApp").start() 
		# App.module("RanksApp").start( fi_type: @fi_type, state_for_rank: @state_for_rank )
		App.module("FooterApp").start()
	
	App.reqres.setHandler "default:region", ->
		App.mainRegion

	App.commands.setHandler "register:instance", (instance, id) ->
		App.register instance, id if App.environment is "development"

	App.commands.setHandler "unregister:instance", (instance, id) ->
		App.unregister instance, id if App.environment is "development"
       
	App.on "initialize:after", ->
		@startHistory()
		@navigate(@rootRoute, trigger: true) unless @getCurrentRoute()
	
	App.shortcuts = ->
		if App.environment is "development"
			window.log = ->
				console.info(arguments...)
			
	App   
	   
	
# http://designmodo.com/