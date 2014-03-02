@FbCURank.module "RanksApp", (RanksApp, App, Backbone, Marionette, $, _) ->
	
	class RanksApp.Router extends Marionette.AppRouter
		appRoutes:                        
			""														: "cover"
			"ranks/:fi_type/:state"				: "showRank" 
	
	API = 
		cover: ->
			new RanksApp.Cover.Controller 
				region: RanksApp.mainRegion
			
		showRank: (fi_type, state_for_rank) ->
			new RanksApp.Show.Controller
				region: RanksApp.mainRegion,   
				fi_type: fi_type,
				state_for_rank: state_for_rank
		
		subscribe: (event) ->
			new RanksApp.Subscribe.Controller event
	
	App.vent.on "subscribe:clicked", (event) ->
		API.subscribe(event)
	                       
	App.addInitializer ->
		new RanksApp.Router
			controller: API