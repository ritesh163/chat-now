class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  
  # validates_format_of :name, with: /^[a-z0-9_]+$/, message: "must be lowercase alphanumerics only"
	validates_length_of :name, maximum: 32, message: "exceeds maximum of 32 characters"
	validates_exclusion_of :name, in: ['www', 'mail', 'ftp'], message: "is not available"


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      debugger
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      #user.name = auth.info.name   # assuming the user model has a name
      #user.avatar = auth.info.image.gsub("http","https")
      user.save!
    end
  end  
end
