@admin.controller 'NextOfKinCrtl', ['$scope', 'User', 'NextOfKin', 'Session', '$routeParams', '$location', ($scope, User, NextOfKin, Session, $routeParams, $location) ->

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

	$scope.addNextOfKin = ->
		NextOfKin.addNextOfKin($scope.userId, $scope.nextOfKin).success((data) ->
			$location.path('users/' + $scope.userId)
		).error (error) ->
			$scope.status = "There was an error uploading your data " + error.message

	$scope.deleteNextOfKin = ->
		NextOfKin.deleteNextOfKin($scope.userId, $scope.id).success((data) ->
			$location.path('users/' + $scope.userId)
		).error (error) ->
			$scope.status = "There was an error deleting your data " + error.message

	$scope.updateNextOfKin = ->
		NextOfKin.updateNextOfKin($scope.userId, $scope.id, $scope.nextOfKin).success((data) ->
			$location.path('users/' + $scope.userId)
		).error (error) ->
			$scope.status = "There was an error deleting your data " + error.message
]
