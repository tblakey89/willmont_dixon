@admin.controller 'LoginCrtl', ['$scope', 'Session', ($scope, Session) ->

	$scope.login = ->
		Session.login($scope.email, $scope.password, $scope.remember)
		$scope.email = ""
		$scope.password= ""

	$scope.$watch (->
		Session.error
		), ((data) ->
			$scope.error = data
			return
			), true
]
