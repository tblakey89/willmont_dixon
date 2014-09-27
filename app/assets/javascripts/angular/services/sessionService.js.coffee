angular.module("sessionService", []).factory "Session", ($location, $http, $q, $window) ->
  
  # Redirect to the given url (defaults to '/')
  redirect = (url) ->
    url = url or "/"
    $location.path url
  service =
    login: (email, password, remember) ->
      $http.post("/api/sessions.json",
        user:
          email: email
          password: password
      ).then((response) ->
        service.currentUser = response.data.user
        if remember is true
          $window.localStorage.authToken = response.data.auth_token
          $window.localStorage.role = response.data.user.role unless response.data.user is undefined
        else
          $window.sessionStorage.authToken = response.data.auth_token
          $window.sessionStorage.role = response.data.user.role unless response.data.user is undefined
        #TODO: Send them back to where they came from
        #$location.path(response.data.redirect);
        $location.path "/"  if service.isAuthenticated()
        service.error = response.data
      )

    getAuthToken: () ->
      if sessionStorage.authToken is null or sessionStorage.authToken is undefined
        localStorage.authToken
      else
        sessionStorage.authToken

    getRole: () ->
      if sessionStorage.authToken is null or sessionStorage.authToken is undefined
        localStorage.role
      else
        sessionStorage.role

    logout: (redirectTo) ->
      $http.delete("/api/sessions.json").then ->
        service.currentUser = null
        $window.sessionStorage.authToken = null
        $window.localStorage.authToken = null
        redirect redirectTo


    register: (email, password, confirm_password) ->
      $http.post("/users.json",
        user:
          email: email
          password: password
          password_confirmation: confirm_password
      ).then (response) ->
        service.currentUser = response.data
        $location.path "/record"  if service.isAuthenticated()


    requestCurrentUser: ->
      if service.isAuthenticated()
        $q.when service.currentUser
      else
        $http.get("/current_user").then (response) ->
          service.currentUser = response.data.user
          service.currentUser

    requestAuthToken: ->
      service.authToken


    currentUser: null
    isAuthenticated: ->
      !!service.currentUser

  service
