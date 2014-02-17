@FbCURank.module "RanksApp.Show", (Show, App, Backbone, Marionette, $, _) -> 

	class Show.Controller extends App.Controllers.Base
		
		initialize: (options) -> 
			{ region, fi_type, state_for_rank } = options
			@fis 	= App.request "fis:entities", fi_type, state_for_rank
			
			@layout = @getLayoutView()
			@listenTo @layout, "show", =>
				@displayRank()
			@show @layout
				                           
			App.execute "when:synced", @, @fis, (fis, resp, options) =>
				newCollection = @fis.forState()
				@displayRank(newCollection)
				@displayTitle(newCollection)
			
		displayRank: (collection) ->
			rankView = @getRankView(collection)
			@layout.rankRegion.show rankView   
		
		displayTitle: (collection) ->
			titleView = @getTitleView(collection)
			@layout.titleRegion.show titleView
		
		getRankView: (collection) ->
			new Show.Rank
				collection: collection

		getTitleView: (collection) ->
			new Show.Title
				collection: collection
		
		getLayoutView: ->
			new Show.Layout