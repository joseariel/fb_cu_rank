@FbCURank.module "HeaderApp.Show", (Show, App, Backbone, Marionette, $, _) ->
	
	Show.Controller =
		
		showHeader: ->
			#links = App.request "header:entities"
			
			headerView = @getHeaderView
			App.headerRegion.show headerView
		
		getHeaderView: ->
			new Show.Headers