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
		
		bookmark: ->
			if window.sidebar and window.sidebar.addPanel # Mozilla Firefox Bookmark
				window.sidebar.addPanel(document.title, window.location.href,'')
			else if window.external and ('AddFavorite' of window.external) # IE Favorite
				window.external.AddFavorite(location.href,document.title)
			else if window.opera and window.print # Opera Hotlist
				@title = document.title
				true
			else # webkit - safari/chrome
				alert('Press ' + (navigator.userAgent.toLowerCase().indexOf('mac') != - 1 ? 'Command/Cmd' : 'CTRL') + ' + D to bookmark this page.')
		 
		displayRank: (collection) ->
			rankView = @getRankView(collection)
			@layout.rankRegion.show rankView   
		
		displayTitle: (collection) ->
			titleView = @getTitleView(collection)
			
			@listenTo titleView, "bookmark:button:clicked", =>
				@bookmark()
			
			@layout.titleRegion.show titleView
		
		getRankView: (collection) ->
			new Show.Rank
				collection: collection

		getTitleView: (collection) ->
			new Show.Title
				collection: collection
		
		getLayoutView: ->
			new Show.Layout