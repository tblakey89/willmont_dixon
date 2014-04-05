@exam.controller 'ExamHomeCrtl', ['$scope', 'Session', '$routeParams', '$location', 'Password', ($scope, Session, $routeParams, $location, Password) ->

	$scope.signIn = ->
		Password.checkPassword($scope.password).success((data) ->
	    	$location.path "/test/cscs_check"
	  	).error (errors) ->
	    	$scope.error = errors.errors

]
