unless Object.keys
  Object.keys = (obj) ->
    keys = []
    for i of obj
      keys.push i  if obj.hasOwnProperty(i)
    keys

@exam = angular.module('exam', ["sessionService", "ngRoute", "adminService", "Directive", 'angularFileUpload'])

@exam.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")
  interceptor = ["$location", "$rootScope", "$q", ($location, $rootScope, $q) ->
    success = (response) ->
      response
    error = (response) ->
      if response.status is 401
        $rootScope.$broadcast "event:unauthorized"
        sessionStorage.clear()
        $location.path "/login"
        return response
      $q.reject response
    (promise) ->
      promise.then success, error
  ]

  $httpProvider.responseInterceptors.push interceptor
]).config(["$routeProvider", '$locationProvider', ($routeProvider, $locationProvider) ->
  $routeProvider.when("/", {
    templateUrl: '../../template/exam/home.html',
    controller: 'ExamHomeCrtl'
  }).when("/test/cscs_check", {
    templateUrl: '../../template/exam/cscs.html',
    controller: 'SignUpCrtl'
  }).when("/test/signup", {
    templateUrl: '../../template/exam/signup.html',
    controller: 'SignUpCrtl'
  }).when("/test/signup_2", {
    templateUrl: '../../template/exam/signup2.html',
    controller: 'SignUpCrtl'
  }).when("/test/next_of_kin", {
    templateUrl: '../../template/exam/next_of_kin.html',
    controller: 'SignUpCrtl'
  }).when("/test/employer", {
    templateUrl: '../../template/exam/employer.html',
    controller: 'SignUpCrtl'
  }).when("/test/section/:id", {
    templateUrl: '../../template/exam/section.html',
    controller: 'ExamCrtl'
  }).otherwise({
    templateUrl: '../../template/exam/home.html',
    controller: 'ExamHomeCrtl'
  })
  $locationProvider.html5Mode(true)
])