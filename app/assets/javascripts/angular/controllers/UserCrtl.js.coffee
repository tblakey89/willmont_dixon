@admin.controller 'UserCrtl', ['$scope', 'User', 'NextOfKin', 'Session', '$routeParams', ($scope, User, NextOfKin, Session, $routeParams) ->

	$scope.id = $routeParams.userId

	$scope.getUsers = ->
		User.getUsers().success((users) ->
	    	$scope.users = users
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message

	$scope.getUser = ->
		User.getUser($scope.id).success((user) ->
	    	$scope.user = user.user
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message

	$scope.getNextOfKins = ->
		NextOfKin.getNextOfKins($scope.id).success((data) ->
	    	$scope.nextOfKins = data
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message

	$scope.getDisciplinaryCards = ->
		User.getDisciplinaryCards($scope.id).success((data) ->
	    	$scope.disciplinaryCards = data
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message
]
