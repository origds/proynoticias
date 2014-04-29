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

  before_save :get_ldap_gid
  
  def get_ldap_gid
    self.gid = Devise::LDAP::Adapter.get_ldap_param(self.login,"gidnumber")
  end
end
