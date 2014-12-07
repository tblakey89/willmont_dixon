@exam.controller 'ExamHomeCrtl', ['$scope', 'Session', '$routeParams', '$location', 'Password', ($scope, Session, $routeParams, $location, Password) ->

	$scope.signIn = ->
		$location.path "/test/cscs_check"

]
