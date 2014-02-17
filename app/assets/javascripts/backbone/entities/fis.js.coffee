@FbCURank.module "Entities", (Entities, App, Backbone, Marionette, $, _) -> 
  
	class Entities.FiModel extends App.Entities.Model
		
		initialize: ->         
			@set('talkingabout', _(@get('talkingabout')).toNumber()) if @get('talkingabout')
			@set('likes', _(@get('likes')).toNumber()) if @get('likes')
			@set('assets', _(@get('assets')).toNumber()) if @get('assets')
			@set('members', _(@get('members')).toNumber()) if @get('members')

	class Entities.FisCollection extends App.Entities.SpreadsheetCollection 
		model: Entities.FiModel
		tabletop: 
			key: '0AhNwLGqqNzr2dDlxOUxCaGRxTTJuQ19QSEJqMFFsX1E'
			sheet: 'Today'
		
		initialize: (models, options) ->
			@fi_type = options.fi_type if (options and options.fi_type)
			if (options and options.state_for_rank)
				@state_for_rank = options.state_for_rank
			
			@comparator = (f) -> -f.get('talkingabout') 
			
			@listenTo @, "reset", @onReset
	  
		url: '/'
		
		onReset: (collection, options) ->
			for model in collection.models
				model.set('rank', @calculateRank(model))
		
		calculateRank: (model) ->                                   
			r = (model.get('talkingabout') * 100) / @maxTalkingAbout()
			_(r).toNumber(2)
		
		maxTalkingAbout: ->
			@maxTalkingAboutCache = _(@max( (m) -> m.get('talkingabout') ).get('talkingabout')).toNumber() if !@maxTalkingAboutCache
			@maxTalkingAboutCache 
		
		forState: -> 
			collection = @whereCollection({ state: @state_for_rank.toUpperCase() })
			collection.maxTalkingAbout() 
			collection.onReset(collection)
			collection
	
	API =
		getFis: (fi_type, state_for_rank) ->
			fis = new Entities.FisCollection [], { fi_type: fi_type, state_for_rank: state_for_rank }
			fis.fetch
				reset: true
			fis
			
	App.reqres.setHandler "fis:entities", (fi_type, state_for_rank) ->
		API.getFis fi_type, state_for_rank 