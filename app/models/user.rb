class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :oauth2_authenticatable, :trackable

  def before_oauth2_auto_create(oauth2_user_attributes)
    self.name = oauth2_user_attributes['user']['name']
    self.email = oauth2_user_attributes['user']['email']
  end
end
