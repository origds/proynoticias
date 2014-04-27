class SessionsController < Devise::SessionsController

  def create
    super
    	puts '----------------------------------------'
    	puts 'INICIO DE SESION'
    	puts '----------------------------------------'
    if current_user.email == ''
    	puts '----------------------------------------'
    	puts 'AGREGANDO MAIL Y ROL'
    	puts '----------------------------------------'
    	current_user.email = current_user.login + "@ldc.usb.ve"
    	current_user.role = 'normal'
    	current_user.save
        flash[:notice] = "Ingresa a tu perfil y completa tus datos."
    end
    if (Devise::LDAP::Adapter.get_ldap_param(self.login,"gid")) == 45
       flash[:error] = "No es profesor."
    end
  end

end
