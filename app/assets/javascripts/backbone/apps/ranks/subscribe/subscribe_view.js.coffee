@FbCURank.module "RanksApp.Subscribe", (Subscribe, App, Backbone, Marionette, $, _) ->     

	class Subscribe.Form extends App.Views.ItemView
		template: "ranks/subscribe/_form"
		
		className: "modal-dialog"
	
		triggers:
			"submit"						: "subscribe:form:submit"

		modelEvents:
			"change:_errors" 	: "changeErrors"
		
		changeErrors: (model, errors, options) ->
			if _.isEmpty(errors) then @removeErrors() else @addErrors errors

		addErrors: (errors = {}) ->
			for name, array of errors
				@addError name, array[0]

		addError: (name, error) ->
			el = @$("[name='#{name}']")
			sm = $("<small>").text(error)
			el.after(sm).closest(".row").addClass("error")
		
		removeErrors: ->
			@$(".error").removeClass("error").find("small").remove()			
		
		onClose: ->
			log "view closing"
			