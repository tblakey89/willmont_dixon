angular.module("Directive", []).directive("menu", ->
  restrict: "E"
  transclude: true
  scope: {
  	active: '@'
  }
  controller: ($scope) ->
    $scope.allowed = (role) ->
      if window.sessionStorage.role >= role && window.sessionStorage.role != undefined
        true
      else
        false
  templateUrl: "/template/menu.html"
).directive("inputmodel", ->
  restrict: "E"
  transclude: true
  scope: {
  	id: '@'
  	model: '='
  	name: '@'
  	type: "@"
  	min: "@"
  	max: "@"
  error: '='
  }
  templateUrl: "/template/input.html"
).directive("search", ->
  restrict: "E"
  transclude: true
  scope: {
    searchmodel: '='
    currentpage: '='
    models: '='
    lastpage: '='
  }
  controller: ($scope, $filter) ->
    $scope.changeSearch = () ->
      $scope.searchmodel = $scope.search
      $scope.array = $scope.models unless $scope.models is undefined
      $scope.currentpage = 1
      $scope.lastpage =  Math.ceil($filter('filter')($scope.array, $scope.search).length/10) unless $scope.array is undefined

  templateUrl: "/template/search.html"
).directive("pagination", ->
  restrict: "E"
  transclude: true
  scope: {
    currentpage: '='
    lastpage: '='
    noArrow: '=?'
  }
  controller: ($scope) ->
    $scope.nextPage = ->
      $scope.currentpage++ unless $scope.currentpage is $scope.lastpage

    $scope.prevPage = ->
      $scope.currentpage-- unless $scope.currentpage is 1

    $scope.toLastPage = ->
      $scope.currentpage = $scope.lastpage

    $scope.keys= []
    $scope.keys.push
      code: 37
      action: ->
        $scope.prevPage() unless $scope.noArrow

    $scope.keys.push
      code: 39
      action: ->
        $scope.nextPage() unless $scope.noArrow

    $scope.$on "keydown", (msg, code) ->
      $scope.keys.forEach (o) ->
        return  if o.code isnt code
        o.action()
        $scope.$apply()
  templateUrl: "/template/pagination.html"
).directive("ngEnter", ->
  (scope, element, attrs) ->
    element.bind "keydown keypress", (event) ->
      if event.which is 13
        scope.$apply ->
          scope.$eval attrs.ngEnter,
            event: event
        event.preventDefault()
).directive("keyTrap", ->
  (scope, elem) ->
    elem.bind "keydown", (event) ->
      scope.$broadcast "keydown", event.keyCode
).directive("exammenu", ->
  restrict: "E"
  transclude: true
  scope: {
    active: '@'
    sections: '='
    user: '='
  }
  controller: ($scope, $window, $location) ->
    $scope.changeSection = (user, section) ->
      if $scope.is_allowed user, section
        if $window.sessionStorage["section" + section.order] isnt "true"
          $location.path "/section/" + section.id

    $scope.isComplete = (type, id) ->
      if type is "section"
        $window.sessionStorage["section" + id] is "true"
      else
        $window.sessionStorage[type] is "true"

    $scope.is_allowed = (user, section) ->
      unless user is undefined or section is undefined
        allowed = true
        allowed = false if section.work_at_height is true and user.work_at_height isnt true
        allowed = false if section.scaffolder is true and user.scaffolder isnt true
        allowed = false if section.ground_worker is true and user.ground_worker isnt true
        allowed = false if section.operate_machinery is true and user.operate_machinery isnt true
        allowed = false if section.lift_loads is true and user.lift_loads isnt true
        allowed = false if section.supervisor is true and user.is_supervisor isnt true
        allowed = false if section.young is true and user.young isnt true
        allowed
      else
        undefined

    $scope.isClickable = (user, section) ->
      if $scope.is_allowed user, section
        "allowed"
      else
        "not_allowed"

    $scope.cscsComplete = ->
      $window.sessionStorage["cscs_check"] == 'true'

  templateUrl: "/template/exam_menu.html"
)