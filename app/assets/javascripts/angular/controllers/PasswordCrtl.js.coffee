@admin.controller 'PasswordCrtl', ['$scope', 'Password', 'Session', '$routeParams', '$location', ($scope, Password, Session, $routeParams, $location) ->

	$scope.getPassword = ->
		Password.getPassword().success((password) ->
	    	$scope.password = password.password
	  	).error (error) ->
	    	$scope.status = "Unable to load password data: " + error.message
	
	$scope.updatePassword = ->
		Password.updatePassword($scope.password.id, $scope.password).success((data) ->
	    	$location.path('password/')
	  	).error (errors) ->
	    	$scope.error = errors.errors

]