@admin.controller 'NextOfKinCrtl', ['$scope', 'User', 'NextOfKin', 'Session', '$routeParams', ($scope, User, NextOfKin, Session, $routeParams) ->

	$scope.userId = $routeParams.userId
	$scope.id = $routeParams.id

	$scope.getNextOfKin = ->
		NextOfKin.getNextOfKin($scope.userId, $scope.id).success((data) ->
	    	$scope.nextOfKin = data.next_of_kin
	    	$scope.getUser()
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message

	$scope.getUser = ->
		User.getUser($scope.userId).success((user) ->
	    	$scope.user = user.user
	  	).error (error) ->
	    	$scope.status = "Unable to load user data: " + error.message
]
