@FbCURank.module "RanksApp.Show", (Show, App, Backbone, Marionette, $, _) -> 

	class Show.Controller extends App.Controllers.Base
		
		initialize: (options) -> 
			{ region, fi_type, state_for_rank } = options           
			@rank = App.request "rank:entity", fi_type, state_for_rank
			
			@layout = @getLayoutView()
			@listenTo @layout, "show", =>
				@displayRank()
			@show @layout             
				                           
			App.execute "when:synced", @, @rank.collection, (fis, resp, options) =>
				@displayRank(@rank.collection)
				@displayTitle(@rank.collection)
			
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