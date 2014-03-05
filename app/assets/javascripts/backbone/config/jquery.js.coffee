do ($) -> 
	# Accepts a url and a callback function to run.
	$.requestCrossDomain = (sync_fctn, method, entity, options = {}) -> 
		if !options.url
			log('No site was passed to requestCrossDomain.')
			return false

		# Take the provided url, and add it to a YQL query. Make sure you encode it!
		yql = 'http://query.yahooapis.com/v1/public/yql?q=' + encodeURIComponent('select * from ' + options.format + ' where url="' + options.url + '"') + '&format=json'
		# &callback=$.crossDomainCallbackProxy 
	
		_.extend options, 
			url: yql
			dataType: "jsonp"
			contentType: "application/json; charset=utf-8" 
             
		sync_fctn(method, entity, options)