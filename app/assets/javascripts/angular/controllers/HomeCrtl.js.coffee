@admin.controller 'HomeCrtl', ['$scope', 'User', 'Session', ($scope, User, Session) ->
	
	$scope.getUsers = ->
		User.getUsers().success((users) ->
	    	$scope.users = users
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message
]
