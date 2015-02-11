module DixieUtils
  def self.cookie_store_options
    {
      expire_after: 2592000, # 1 month
      key: '_dixie-auth_session',
      domain: ENV['DOMAIN']
    }
  end

  module Authentication
    def self.included(klass)
      klass.before_action :authenticate_with_dixie
      klass.helper_method :current_user
      klass.helper_method :logout_button
    end

    private

    def require_role(role)
      if current_user.nil? || !current_user.roles.include?(role)
        head :unauthorized
      end
    end

    def authenticate_with_dixie
      if current_user.nil?
        if params[:format] == 'json'
          head :unauthorized
        else
          session[:redirect_back_url] = request.original_url
          flash[:notice] = "You need to sign in."
          redirect_to(ENV['AUTH_URL'])
        end
      end
    end

    def current_user
      @current_user ||= load_current_user
    end

    def load_current_user
      if hash = session[:current_user]
        if Time.at(hash["expire_at"]).future?
          OpenStruct.new(hash.slice("username", "roles"))
        end
      end
    end

    def logout_button
      "<div class='logout-button-div'><form action='#{ENV['AUTH_URL']}session' method='post'><input name='_method' type='hidden' value='delete' /><input type='submit' value='Logout' class='btn btn-warning btn-logout' /></form></div>".html_safe
    end

    def refresh_session_expiration_time
      session[:current_user]["expire_at"] = 1.month.from_now.to_i
    end
  end
end
