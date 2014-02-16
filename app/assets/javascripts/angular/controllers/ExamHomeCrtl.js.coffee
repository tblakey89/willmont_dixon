@exam.controller 'ExamHomeCrtl', ['$scope', 'Session', '$routeParams', '$location', ($scope, Session, $routeParams, $location) ->

	$scope.signIn = ->
		if $scope.password is "password"
			$location.path "/cscs_check"

]
