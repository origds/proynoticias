class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :rememberable, :trackable,
         :authentication_keys => [:login]
         # :validatable, :recoverable
         
  has_many :reports

  ROLES = %w[admin privileged normal]
  include RoleModel
  roles_attribute :roles_mask 
  roles :admin, :privileged, :normal

end
