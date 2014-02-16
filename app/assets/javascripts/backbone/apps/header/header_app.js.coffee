@FbCURank.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = true
	
	API =
		listHeader: ->
			HeaderApp.Show.Controller.showHeader()
	
	HeaderApp.on "start", ->
		API.showHeader()