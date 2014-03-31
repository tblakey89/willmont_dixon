@admin.controller 'LogoutCrtl', ['$scope', 'Admin', 'Session', '$routeParams', '$location', '$window', ($scope, Admin, Session, $routeParams, $location, $window) ->

	$scope.logout = ->
		$window.sessionStorage.authToken = ""
		$location.path('login')

	$scope.viewable = ->
		$location.path() isnt '/login'
]
