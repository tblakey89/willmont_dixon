@exam = angular.module('exam', ["sessionService", "ngRoute", "adminService", "Directive", 'angularFileUpload'])

@exam.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")
  interceptor = ["$location", "$rootScope", "$q", ($location, $rootScope, $q) ->
    success = (response) ->
      response
    error = (response) ->
      if response.status is 401
        $rootScope.$broadcast "event:unauthorized"
        $location.path "/login"
        return response
      $q.reject response
    (promise) ->
      promise.then success, error
  ]

  $httpProvider.responseInterceptors.push interceptor
]).config(["$routeProvider", ($routeProvider) ->
  $routeProvider.when("/", {
    templateUrl: '../../template/exam/home.html',
    controller: 'ExamHomeCrtl'
  }).otherwise({
    templateUrl: '../../template/exam/home.html',
    controller: 'ExamHomeCrtl'
  })
])