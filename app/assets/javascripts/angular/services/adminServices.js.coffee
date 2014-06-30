angular.module("adminService", []).factory("User", ["$http", "Session", ($http, Session, $window) ->
  urlBase = "/api/users/"
  dataFactory = {}

  dataFactory.getUsers = () ->
    $http.get(urlBase, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.getUser = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.getDisciplinaryCards = (id) ->
    $http.get(urlBase + id + "/disciplinary_cards", { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.updateUser = (id, user) ->
    user.cscs_expiry_date = user.cscs_expiry_month + "-01" unless user.cscs_expiry_month is undefined
    $http.put urlBase + id, { user: user }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.deleteUser = (id) ->
    $http.delete urlBase + id, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.checkCSCS = (user) ->
    $http.post urlBase + "cscs_check", { user: user }

  dataFactory
]).factory("Admin", ["$http", "Session", ($http, Session, $window) ->
  urlBase = "/api/admins/"
  dataFactory = {}

  dataFactory.getAdmins = () ->
    $http.get(urlBase, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.getAdmin = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.addAdmin = (admin) ->
    $http.post urlBase, { admin: admin }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.updateAdmin = (id, admin) ->
    $http.put urlBase + id, { admin: admin }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.deleteAdmin = (id) ->
    $http.delete urlBase + id, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory
]).factory("NextOfKin", ["$http", "Session", ($http, Session, $window) ->
  dataFactory = {}

  urlBase = (userId) ->
  	"/api/users/" + userId + "/next_of_kins/"

  dataFactory.getNextOfKins = (userId) ->
    $http.get(urlBase(userId), { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.getNextOfKin = (userId, id) ->
    $http.get(urlBase(userId) + id, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.addNextOfKin = (userId, nextOfKin) ->
    $http.post urlBase(userId), { next_of_kin: nextOfKin }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.updateNextOfKin = (userId, id, nextOfKin) ->
    $http.put urlBase(userId) + id, { next_of_kin: nextOfKin }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.deleteNextOfKin = (userId, id) ->
    $http.delete urlBase(userId) + id, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory
]).factory("Employer", ["$http", "Session", ($http, Session, $window) ->
  dataFactory = {}

  urlBase = (userId) ->
    "/api/users/" + userId + "/employers/"

  dataFactory.getEmployers = (userId) ->
    $http.get(urlBase(userId), { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.getEmployer = (userId, id) ->
    $http.get(urlBase(userId) + id, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.addEmployer = (userId, employer) ->
    $http.post urlBase(userId), { employer: employer }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.updateEmployer = (userId, id, employer) ->
    $http.put urlBase(userId) + id, { employer: employer }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.deleteEmployer = (userId, id) ->
    $http.delete urlBase(userId) + id, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory
]).factory("Section", ["$http", "Session", ($http, Session, $window) ->
  dataFactory = {}
  urlBase = "/api/pre_enrolment_tests/1/sections/"

  dataFactory.getSections = ->
    $http.get(urlBase, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.getSection = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.getQuestions = (id) ->
    $http.get(urlBase + id + "/questions", { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.getVideos = (id) ->
    $http.get(urlBase + id + "/videos", { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.addSection = (section) ->
    $http.post urlBase, { section: section }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.updateSection = (id, section) ->
    $http.put urlBase + id, { section: section }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.deleteSection = (id) ->
    $http.delete urlBase + id, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.checkAnswers = (id, answers) ->
    $http.post urlBase + id + "/check_answers", { answers: answers }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory
]).factory("Question", ["$http", "Session", ($http, Session, $window) ->
  dataFactory = {}
  urlBase = "/api/pre_enrolment_tests/1/questions/"

  dataFactory.getQuestions = ->
    $http.get(urlBase, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.getQuestion = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.addQuestion = (question) ->
    $http.post urlBase, { question: question }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.updateQuestion = (id, question) ->
    $http.put urlBase + id, { question: question }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.deleteQuestion = (id) ->
    $http.delete urlBase + id, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory
]).factory("DisciplinaryCard", ["$http", "Session", ($http, Session, $window) ->
  dataFactory = {}
  urlBase = "/api/disciplinary_cards/"

  dataFactory.getDisciplinaryCards = ->
    $http.get(urlBase, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.getDisciplinaryCard = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.addDisciplinaryCard = (userId, disciplinaryCard) ->
    disciplinaryCard.user_id = userId
    $http.post urlBase, { disciplinary_card: disciplinaryCard }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.deleteDisciplinaryCard = (id) ->
    $http.delete urlBase + id, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory
]).factory("Video", ["$http", "Session", ($http, Session, $window) ->
  dataFactory = {}
  urlBase = "/api/pre_enrolment_tests/1/videos/"

  dataFactory.getVideos = ->
    $http.get(urlBase, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.getVideo = (id) ->
    $http.get(urlBase + id, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.updateVideo = (id, video) ->
    $http.put urlBase + id, { video: video }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.getVideoAndQuestions = (id) ->
    $http.get(urlBase + id + "/and_questions", { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.addVideo = (video) ->
    $http.post urlBase, { video: video }, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory.deleteVideo = (id) ->
    $http.delete urlBase + id, { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory
]).factory("PreEnrolmentTest", ["$http", "Session", ($http, Session, $window) ->
  dataFactory = {}
  urlBase = "/api/pre_enrolment_tests/1/"

  dataFactory.beginTest = ->
    $http.get(urlBase + "begin_test", { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.getInfo = ->
    $http.get("/api/pre_enrolment_tests", { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory
]).factory("Password", ["$http", "Session", ($http, Session, $window) ->
  dataFactory = {}
  urlBase = "/api/passwords/"

  dataFactory.getPassword = ->
    $http.get(urlBase, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.updatePassword = (id, password) ->
    $http.put(urlBase + id, { password: password }, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory.checkPassword = (password) ->
    $http.post(urlBase + "check_password", { password: password }, { headers: { 'auth-token': Session.getAuthToken() } })

  dataFactory
]).factory("ExamSections", ["$http", "Session", ($http, Session, $window) ->
  dataFactory = {}
  dataFactory.sections = ""

  dataFactory.getSections = ->
    if dataFactory.sections is ""
      $http.get("/api/pre_enrolment_tests/1/sections/all", { headers: { 'auth-token': Session.getAuthToken() } })
    else
      dataFactory.sections

  dataFactory
]).factory("CurrentUser", ["$http", "Session", ($http, Session, $window) ->
  dataFactory = {}
  dataFactory.user = ""

  dataFactory.getUser = ->
    if dataFactory.user is ""
      $http.post("/api/users/find_by_auth_token", { auth_token: Session.getAuthToken() }, { headers: { 'auth-token': Session.getAuthToken() } })
    else
      dataFactory.user

  dataFactory.submitResults = ->
    $http.get "/api/users/submit_results", { headers: { 'auth-token': Session.getAuthToken() } }

  dataFactory
])