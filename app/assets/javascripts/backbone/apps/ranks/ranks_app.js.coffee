@FbCURank.module "RanksApp", (RanksApp, App, Backbone, Marionette, $, _) ->
	
	class RanksApp.Router extends Marionette.AppRouter
		appRoutes:                        
			# ""														: "" Deal with this
			"ranks/:fi_type/:state"				: "showRank" 
	
	API =
		showRank: (fi_type, state_for_rank) ->
			new RanksApp.Show.Controller
				region: RanksApp.mainRegion,   
				fi_type: fi_type,
				state_for_rank: state_for_rank
	                       
	App.addInitializer ->
		new RanksApp.Router
			controller: API