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
  }).when("/cscs_check", {
    templateUrl: '../../template/exam/cscs.html',
    controller: 'SignUpCrtl'
  }).when("/signup", {
    templateUrl: '../../template/exam/signup.html',
    controller: 'SignUpCrtl'
  }).when("/signup_2", {
    templateUrl: '../../template/exam/signup2.html',
    controller: 'SignUpCrtl'
  }).when("/next_of_kin", {
    templateUrl: '../../template/exam/next_of_kin.html',
    controller: 'SignUpCrtl'
  }).when("/employer", {
    templateUrl: '../../template/exam/employer.html',
    controller: 'SignUpCrtl'
  }).when("/section/:id", {
    templateUrl: '../../template/exam/section.html',
    controller: 'ExamCrtl'
  }).otherwise({
    templateUrl: '../../template/exam/home.html',
    controller: 'ExamHomeCrtl'
  })
])