class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable

  # validates_format_of :name, with: /^[a-z0-9_]+$/, message: "must be lowercase alphanumerics only"
	validates_length_of :name, maximum: 32, message: "exceeds maximum of 32 characters"
	validates_exclusion_of :name, in: ['www', 'mail', 'ftp'], message: "is not available"

	def self.connect_to_linkedin(auth, signed_in_resource=nil)
		debugger
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.info.first_name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                          )
      end
    end
  end   
	
end
