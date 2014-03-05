do (Backbone, Marionette) ->
	
	class Marionette.Region.Modal extends Marionette.Region
		
		onShow: (view) ->
			@$el.on 'hidden.bs.modal', (e) => @close()
			@$el.modal()
			
		hide: ->
			@$el.modal('hide') 