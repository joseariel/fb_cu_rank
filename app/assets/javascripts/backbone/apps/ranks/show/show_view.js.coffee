@FbCURank.module "RanksApp.Show", (Show, App, Backbone, Marionette, $, _) ->
	
	class Show.Layout extends App.Views.Layout
		template: "ranks/show/layout" 
		className: "container"
		
		regions:
			titleRegion: 	"#title-region"
			rankRegion:	"#rank-region" 
	
	class Show.Title extends App.Views.ItemView
		template: "ranks/show/_title"  
		tagName: 'h4' 
		className: 'text-center fbColor' 
		
		serializeData: ->
			data = super()                                                       
			if @collection 
				data.rankLength = (if @collection.length > 30 then 30 else @collection.length)
			data
		
	class Show.Empty extends App.Views.ItemView
		template: "ranks/show/_empty"
		className: "text-center"
		
	class Show.Fi extends App.Views.ItemView
		template: "ranks/show/_fi"
		className: "fi progress"
		
		triggers:                                           
			"click" 										: "rank:fi:clicked"
	  
		onRender: ->
			@$el.find('.nameLabel').width((@model.get('name').length * 10) + 100 + 'px')
	
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
		