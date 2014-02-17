@FbCURank.module "HeaderApp", (HeaderApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
	
	API =
		showHeader: ->
			new HeaderApp.Show.Controller()
	
	HeaderApp.on "start", ->
		API.showHeader()