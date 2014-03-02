@FbCURank.module "RanksApp.Cover", (Cover, App, Backbone, Marionette, $, _) ->
	
	class Cover.Layout extends App.Views.Layout
		template: "ranks/cover/layout" 
		className: "container"
		
		regions:
			heroUnitRegion: 	"#hero-unit-region"
	
	class Cover.HeroUnit extends App.Views.ItemView
		template: "ranks/cover/hero_unit"    
		
		events:
			"click button": (e) -> @trigger "subscribe:clicked", e