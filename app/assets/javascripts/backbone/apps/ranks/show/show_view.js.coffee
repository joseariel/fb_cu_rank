@FbCURank.module "RanksApp.Show", (Show, App, Backbone, Marionette, $, _) ->
	
	class Show.Layout extends App.Views.Layout
		template: "ranks/show/layout" 
		className: "container"
		
		regions:
			titleRegion: 	"#title-region"
			rankRegion:	"#rank-region" 
	
	class Show.Title extends App.Views.ItemView
		template: "ranks/show/_title"    
		
		triggers:
			"click .btn-bookmark": "bookmark:button:clicked"
		
		serializeData: ->
			data = super()                                                       
			if @collection 
				data.rankLength = (if @collection.length > 30 then 30 else @collection.length)
				data.fi_type = @collection.fi_type
			data 
		
		templateHelpers: ->
			
			formatted_fi_type: -> FbCURank.Entities.FiTypes[@fi_type].plural
				
			formatted_state: -> FbCURank.Entities.States.us[@items[0].state]
		
	class Show.Empty extends App.Views.ItemView
		template: "ranks/show/_empty"
		className: "text-center"
		
	class Show.Fi extends App.Views.ItemView
		template: "ranks/show/_fi"
		className: "fi progress progress-lg"
		
		triggers:                                           
			"click" 										: "rank:fi:clicked"
	           
		onShow: ->
			@$('.nameLabel').width((@model.get('name').length * 10) + 100 + 'px')
	
	class Show.Rank extends App.Views.CompositeView
		template: "ranks/show/rank"
		itemView: Show.Fi
		emptyView: Show.Empty
		itemViewContainer: ".rank-container"
		limit: 30 
		
		showCollection: ->           
			iterator = (item, index) ->
				ItemView = @getItemView item
				@addItemView item, ItemView, index 
			_.each(@collection.first(@limit), iterator, @)
		