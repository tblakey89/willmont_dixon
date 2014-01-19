class Permission
  def initialize(user)
    allow :pages, [:home]
    allow :sessions, [:create, :failure]
    allow :registrations, [:create]
    if user
      allow :users, [:show, :update] do |the_user|
        the_user.id == user.id
      end
      allow "api/disciplinary_cards", [:index, :show, :create, :update, :destroy]
      allow "api/users", [:index, :show, :disciplinary_cards, :update, :destroy]
      allow "api/questions", [:show, :index, :create, :destroy, :update]
      allow "api/sections", [:index, :show, :update, :create, :destroy, :questions]
      allow "api/next_of_kins", [:index, :show, :update, :destroy, :create]
      allow :pre_enrolment_tests, [:show]
      #allow_if_owned :images, [:update, :edit, :delete, :destroy], user
      #allow_all if user.is_super_admin?
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
