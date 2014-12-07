class Permission
  def initialize(user)
    allow "pages", [:home]
    allow "api/sessions", [:create, :failure]
    allow "api/registrations", [:create]
    allow "api/users", [:cscs_check]
    allow "api/passwords", [:check_password]

    if user
      if user.role == 1
        allow :users, [:show, :update] do |the_user|
          the_user.id == user.id
        end
        allow "api/users", [:show, :update, :submit_results, :find_by_auth_token, :save_progress]
        allow "api/questions", [:show, :index, :create, :destroy, :update]
        allow "api/sections", [:index, :show, :update, :create, :destroy, :questions, :videos, :check_answers, :all]
        allow "api/next_of_kins", [:show, :update] do |next_of_kin|
          next_of_kin.user_id == user.id
        end
        allow "api/next_of_kins", [:create]
        allow "api/employers", [:show, :update] do |employer|
          employer.user_id == user.id
        end
        allow "api/employers", [:create]
        allow "api/pre_enrolment_tests", [:show, :begin_test]
        allow "api/videos", [:show, :and_questions]
      end
      if user.role == 2
        allow "api/disciplinary_cards", [:index, :show, :create]
        allow "api/users", [:index, :show, :disciplinary_cards, :find_by_auth_token]
        allow "api/next_of_kins", [:show, :index]
        allow "api/employers", [:show, :index]
        allow "api/pre_enrolment_tests", [:index]
      end
      if user.role == 3
        allow "api/disciplinary_cards", [:index, :show, :create, :update, :destroy]
        allow "api/users", [:index, :show, :disciplinary_cards, :update, :destroy, :find_by_auth_token]
        allow "api/admins", [:index, :show, :update, :destroy, :create]
        allow "api/next_of_kins", [:index, :show, :update, :destroy, :create]
        allow "api/employers", [:index, :show, :update, :destroy, :create]
        allow "api/passwords", [:create, :index, :update]
        allow "api/pre_enrolment_tests", [:index]
      end
      if user.role == 4
        allow "api/disciplinary_cards", [:index, :show, :create, :update, :destroy]
        allow "api/users", [:index, :show, :disciplinary_cards, :update, :destroy, :find_by_auth_token]
        allow "api/admins", [:index, :show, :update, :destroy, :create]
        allow "api/next_of_kins", [:index, :show, :update, :destroy, :create]
        allow "api/employers", [:index, :show, :update, :destroy, :create]
        allow "api/videos", [:index, :show, :update, :destroy, :create, :and_questions]
        allow "api/sections", [:index, :show, :update, :create, :destroy, :questions, :videos, :check_answers, :all]
        allow "api/questions", [:index, :show, :update, :create, :destroy]
        allow "api/passwords", [:create, :index, :update]
        allow "api/pre_enrolment_tests", [:index]
      end
    end
  end

  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed== true || resource && allowed.call(resource))
  end

  def allow_all
    @allow_all = true
  end

  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end

  def allow_if_owned(controllers, actions, user)
    allow controllers, actions do |item|
      item.user_id == user.id
    end
  end

  def allow_param(resources, attributes)
    @allowed_params ||= {}
    Array(resources).each do |resource|
      @allowed_params[resource]  ||= []
      @allowed_params[resource] = Array(attributes)
    end
  end

  def allow_param?(resource, attribute)
    if @allow_all
      true
    elsif @allowed_params && @allowed_params[:resource]
      @allowed_params[resource].include? attribute
    end
  end

  def permit_params!(params)
    if @allow_all
      params.permit!
    elsif @allowed_params
      @allowed_params.each do |resource, attributes|
        if params[resource].respond_to? :permit
          params[resource] = params[resource].permit(*attributes)
        end
      end
    end
  end
end
