@FbCURank.module "RanksApp.Subscribe", (Subscribe, App, Backbone, Marionette, $, _) -> 

	class Subscribe.Controller extends App.Controllers.Base
		
		initialize: (event) ->
			@subscriber = App.request "subscriber:entity" 
			subscribeView = @getSubscribeView()   
			
			@listenTo subscribeView, "subscribe:form:submit", @formSubmit
			
			App.modalRegion.show subscribeView
		
		formSubmit: (args) ->         	
			data = Backbone.Syphon.serialize args.view
			model = args.view.model
			@processFormSubmit data, model

		processFormSubmit: (data, model) ->
			log data, model
			model.save data
						
		getSubscribeView: ->
			new Subscribe.Form 
				model: @subscriber