@FbCURank.module "RanksApp.Cover", (Cover, App, Backbone, Marionette, $, _) -> 

	class Cover.Controller extends App.Controllers.Base
		
		initialize: (options) -> 
			{ region } = options           
			                          
			@layout = @getLayoutView()
			@listenTo @layout, "show", =>
				@displayHeroUnit()
			@show @layout
		      
		displayHeroUnit: ->
			heroView = @getHeroUnitView()
			
			@listenTo heroView, "subscribe:clicked", (event) ->
				App.vent.trigger "subscribe:clicked", event
			
			@layout.heroUnitRegion.show heroView
		
		getHeroUnitView: ->
			new Cover.HeroUnit  
		
		getLayoutView: ->
			new Cover.Layout