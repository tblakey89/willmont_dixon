@admin = angular.module('admin', ["sessionService", "ngRoute", "adminService", "Directive"])

@admin.config(['$httpProvider', ($httpProvider) ->
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
  $routeProvider.when("/login", {
    templateUrl: '../../template/login.html',
    controller: 'LoginCrtl'
  }).when("/users", {
    templateUrl: '../../template/users.html',
    controller: 'UserCrtl'
  }).when("/users/:userId", {
    templateUrl: '../../template/user.html',
    controller: 'UserCrtl'
  }).when("/users/:userId/edit", {
    templateUrl: '../../template/user_form.html',
    controller: 'UserCrtl'
  }).when("/users/:userId/next_of_kins/new", {
    templateUrl: '../../template/next_of_kin_new.html',
    controller: 'NextOfKinCrtl'
  }).when("/users/:userId/next_of_kins/:id", {
    templateUrl: '../../template/next_of_kin.html',
    controller: 'NextOfKinCrtl'
  }).when("/sections", {
    templateUrl: '../../template/section/sections.html',
    controller: 'SectionCrtl'
  }).when("/sections/new", {
    templateUrl: '../../template/section/section_new.html',
    controller: 'SectionCrtl'
  }).when("/sections/:id", {
    templateUrl: '../../template/section/section.html',
    controller: 'SectionCrtl'
  }).when("/sections/:id/edit", {
    templateUrl: '../../template/section/section_edit.html',
    controller: 'SectionCrtl'
  }).when("/questions", {
    templateUrl: '../../template/question/questions.html',
    controller: 'QuestionCrtl'
  }).when("/questions/new", {
    templateUrl: '../../template/question/question_new.html',
    controller: 'QuestionCrtl'
  }).when("/questions/:id", {
    templateUrl: '../../template/question/question.html',
    controller: 'QuestionCrtl'
  }).when("/questions/:id/edit", {
    templateUrl: '../../template/question/question_edit.html',
    controller: 'QuestionCrtl'
  }).otherwise({
    templateUrl: '../../template/home.html',
    controller: 'HomeCrtl'
  })
])