@admin.controller 'LoginCrtl', ['$scope', 'Session', ($scope, Session) ->

	$scope.login = ->
		Session.login($scope.email, $scope.password)


]
