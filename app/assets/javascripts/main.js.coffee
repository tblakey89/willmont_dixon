@admin = angular.module('admin', ["sessionService", "ngRoute", "adminService", "Directive", 'angularFileUpload'])

@admin.filter "slice", ->
    (arr, start, end) ->
        arr.slice start, end



@admin.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")
  interceptor = ["$location", "$rootScope", "$q", ($location, $rootScope, $q) ->
    success = (response) ->
      response
    error = (response) ->
      if response.status is 401
        $rootScope.$broadcast "event:unauthorized"
        sessionStorage.clear()
        $location.path "/admin/login"
        return response
      $q.reject response
    (promise) ->
      promise.then success, error
  ]

  $httpProvider.responseInterceptors.push interceptor
]).config(["$routeProvider", '$locationProvider', ($routeProvider, $locationProvider) ->
  $routeProvider.when("/admin/login", {
    templateUrl: '/template/login.html',
    controller: 'LoginCrtl'
  }).when("/admin/users", {
    templateUrl: '/template/users.html',
    controller: 'UserCrtl'
  }).when("/admin/users/:userId", {
    templateUrl: '/template/user.html',
    controller: 'UserCrtl'
  }).when("/admin/users/:userId/edit", {
    templateUrl: '/template/user/user_edit.html',
    controller: 'UserCrtl'
  }).when("/admin/admins", {
    templateUrl: '/template/admin/admins.html',
    controller: 'AdminCrtl'
  }).when("/admin/admins/new", {
    templateUrl: '/template/admin/admin_new.html',
    controller: 'AdminCrtl'
  }).when("/admin/admins/:id", {
    templateUrl: '/template/admin/admin.html',
    controller: 'AdminCrtl'
  }).when("/admin/admins/:id/edit", {
    templateUrl: '/template/admin/admin_edit.html',
    controller: 'AdminCrtl'
  }).when("/admin/users/:userId/next_of_kins/new", {
    templateUrl: '/template/next_of_kin_new.html',
    controller: 'NextOfKinCrtl'
  }).when("/admin/users/:userId/next_of_kins/:id/edit", {
    templateUrl: '/template/next_of_kin_edit.html',
    controller: 'NextOfKinCrtl'
  }).when("/admin/users/:userId/next_of_kins/:id", {
    templateUrl: '/template/next_of_kin.html',
    controller: 'NextOfKinCrtl'
  }).when("/admin/sections", {
    templateUrl: '/template/section/sections.html',
    controller: 'SectionCrtl'
  }).when("/admin/sections/new", {
    templateUrl: '/template/section/section_new.html',
    controller: 'SectionCrtl'
  }).when("/admin/sections/:id", {
    templateUrl: '/template/section/section.html',
    controller: 'SectionCrtl'
  }).when("/admin/sections/edit/:id", {
    templateUrl: '/template/section/section_edit.html',
    controller: 'SectionCrtl'
  }).when("/admin/questions", {
    templateUrl: '/template/question/questions.html',
    controller: 'QuestionCrtl'
  }).when("/admin/questions/new", {
    templateUrl: '/template/question/question_new.html',
    controller: 'QuestionCrtl'
  }).when("/admin/questions/:id", {
    templateUrl: '/template/question/question.html',
    controller: 'QuestionCrtl'
  }).when("/admin/questions/:id/edit", {
    templateUrl: '/template/question/question_edit.html',
    controller: 'QuestionCrtl'
  }).when("/admin/disciplinary_cards", {
    templateUrl: '/template/disciplinary_card/disciplinary_cards.html',
    controller: 'DisciplinaryCardCrtl'
  }).when("/admin/users/:userId/new_disciplinary_card", {
    templateUrl: '/template/user/disciplinary_card_new.html',
    controller: 'UserCrtl'
  }).when("/admin/disciplinary_cards/:id", {
    templateUrl: '/template/disciplinary_card/disciplinary_card.html',
    controller: 'DisciplinaryCardCrtl'
  }).when("/admin/videos", {
    templateUrl: '/template/video/videos.html',
    controller: 'VideoCrtl'
  }).when("/admin/videos/new", {
    templateUrl: '/template/video/video_new.html',
    controller: 'VideoCrtl'
  }).when("/admin/videos/:id", {
    templateUrl: '/template/video/video.html',
    controller: 'VideoCrtl'
  }).when("/admin/password", {
    templateUrl: '/template/password/password.html',
    controller: 'PasswordCrtl'
  }).when("/admin/password/edit", {
    templateUrl: '/template/password/password_edit.html',
    controller: 'PasswordCrtl'
  }).otherwise({
    templateUrl: '/template/home.html',
    controller: 'HomeCrtl'
  })
  $locationProvider.html5Mode(true)
])