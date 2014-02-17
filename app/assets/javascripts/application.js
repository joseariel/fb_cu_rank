// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require lib/jquery-1.11.0  
//= require lib/jquery.transit  
//= require lib/underscore
//= require lib/underscore.string
//= require lib/backbone      
//= require lib/backbone.marionette 
//= require lib/backbone.tabletop
//= require lib/backbone.tabletopsync
//= require lib/handlebars-v1.3.0
//= require lib/bootstrap  
//= require_tree ./backbone/config     
//= require backbone/app      
//= require_tree ./backbone/controllers
//= require_tree ./backbone/views    
//= require_tree ./backbone/entities  
//= require_tree ./backbone/components  
//= require_tree ./backbone/apps

_.mixin(_.str.exports());
