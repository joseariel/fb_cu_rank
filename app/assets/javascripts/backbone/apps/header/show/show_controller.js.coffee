@FbCURank.module "HeaderApp.Show", (Show, App, Backbone, Marionette, $, _) ->
	
	class Show.Controller extends App.Controllers.Base
		
		initialize: ->
			#links = App.request "header:entities"
			
			headerView = @getHeaderView()
			App.headerRegion.show headerView
		
		getHeaderView: ->
			new Show.Header