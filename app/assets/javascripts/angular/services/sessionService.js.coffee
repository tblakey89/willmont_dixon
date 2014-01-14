angular.module("sessionService", []).factory "Session", ($location, $http, $q, $window) ->
  
  # Redirect to the given url (defaults to '/')
  redirect = (url) ->
    url = url or "/"
    $location.path url
  service =
    login: (email, password) ->
      $http.post("/api/sessions.json",
        user:
          email: email
          password: password
      ).then (response) ->
        service.currentUser = response.data.user
        $window.sessionStorage.authToken = response.data.auth_token
        
        #TODO: Send them back to where they came from
        #$location.path(response.data.redirect);
        $location.path "/"  if service.isAuthenticated()


    logout: (redirectTo) ->
      $http.delete("/api/sessions.json").then ->
        service.currentUser = null
        $window.sessionStorage.authToken = null
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
