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
    templateUrl: '../../template/user/user_edit.html',
    controller: 'UserCrtl'
  }).when("/admins", {
    templateUrl: '../../template/admin/admins.html',
    controller: 'AdminCrtl'
  }).when("/admins/new", {
    templateUrl: '../../template/admin/admin_new.html',
    controller: 'AdminCrtl'
  }).when("/admins/:id", {
    templateUrl: '../../template/admin/admin.html',
    controller: 'AdminCrtl'
  }).when("/admins/:id/edit", {
    templateUrl: '../../template/admin/admin_edit.html',
    controller: 'AdminCrtl'
  }).when("/users/:userId/next_of_kins/new", {
    templateUrl: '../../template/next_of_kin_new.html',
    controller: 'NextOfKinCrtl'
  }).when("/users/:userId/next_of_kins/:id/edit", {
    templateUrl: '../../template/next_of_kin_edit.html',
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
  }).when("/disciplinary_cards", {
    templateUrl: '../../template/disciplinary_card/disciplinary_cards.html',
    controller: 'DisciplinaryCardCrtl'
  }).when("/users/:userId/new_disciplinary_card", {
    templateUrl: '../../template/user/disciplinary_card_new.html',
    controller: 'UserCrtl'
  }).when("/disciplinary_cards/:id", {
    templateUrl: '../../template/disciplinary_card/disciplinary_card.html',
    controller: 'DisciplinaryCardCrtl'
  }).when("/videos", {
    templateUrl: '../../template/video/videos.html',
    controller: 'VideoCrtl'
  }).when("/videos/new", {
    templateUrl: '../../template/video/video_new.html',
    controller: 'VideoCrtl'
  }).when("/videos/:id", {
    templateUrl: '../../template/video/video.html',
    controller: 'VideoCrtl'
  }).otherwise({
    templateUrl: '../../template/home.html',
    controller: 'HomeCrtl'
  })
])