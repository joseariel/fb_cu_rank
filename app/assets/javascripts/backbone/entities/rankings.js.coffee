@FbCURank.module "Entities", (Entities, App, Backbone, Marionette, $, _) -> 
  
	class Entities.Rank extends App.Entities.Model
		
		initialize: ->                                
			@set('benchmark', 45.00)
			@calculate() if @collection 
			
		calculate: (collection, options) -> 
			@maxTalkingAbout() # Calculate and cache the max talkingabout
		  
			i = 0
			while i < @collection.models.length
				model = @collection.models[i] 
				model.set('rank', @calculateFor(model))                
				model.set('position', i+1)                
				i++                                

		calculateFor: (model) ->
			if model.get('talkingabout')                                  
				r = (model.get('talkingabout') * 100) / @maxTalkingAbout()
				_(r).toNumber(2)

		maxTalkingAbout: ->
			@maxTalkingAboutCache = _(@collection.max( (m) -> m.get('talkingabout') or 0 ).get('talkingabout')).toNumber() if !@maxTalkingAboutCache
			@maxTalkingAboutCache 
	  
		fetch: (args) ->
			@collection = new Entities.FisCollection [], { 
				fi_type: @get('fi_type'), 
				state_for_rank: @get('state_for_rank')
				benchmark: @get('benchmark') 
			}
			
			@listenTo @collection, "reset", @calculate 
			
			@collection.fetch 
				query: { "state": @get('state_for_rank').toUpperCase() }
				limit: 1000
				reset: true
			@collection
	
	API =
		getRank: (fi_type, state_for_rank) ->
			rank = new Entities.Rank 
				fi_type: fi_type
				state_for_rank: state_for_rank
			rank.fetch()
			rank
			
	App.reqres.setHandler "rank:entity", (fi_type, state_for_rank) ->
		API.getRank fi_type, state_for_rank