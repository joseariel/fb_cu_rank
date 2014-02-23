@FbCURank.module "HeaderApp.Show", (Show, App, Backbone, Marionette, $, _) ->  
	          
	class Show.Header extends Marionette.ItemView
		template: "header/show/templates/header" 
		
		ui:
			shasticPointer: ".shastic-pointer"
		
		events:                                           
			"click .shastic-pointer": "pointToShastic" 
		
		pointToShastic: (e) ->	
			href = @ui.shasticPointer.attr('href')
			App.ga.link.clicked href