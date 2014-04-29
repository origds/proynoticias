class SessionsController < Devise::SessionsController

  def create
    super
    	puts '----------------------------------------'
    	puts 'INICIO DE SESION'
    	puts '----------------------------------------'
    if ((100 == Devise::LDAP::Adapter.get_ldap_param(current_user.login,"gidnumber")) or ((current_user.login != '09-10177') and (current_user.login != '09-10336')))
        
        flash[:alert] = "Disculpe, no tiene permisos para acceder."
        current_user.destroy

    else
        if current_user.email == ''
            puts '----------------------------------------'
            puts 'AGREGANDO MAIL Y ROL'
            puts '----------------------------------------'
            current_user.email = current_user.login + "@ldc.usb.ve"
            current_user.role = 'normal'
            current_user.name = current_user.login
            current_user.lastname = current_user.login
            current_user.save
            flash[:notice] = "Ingresa a tu perfil y completa tus datos."
        end
    
    end
  end
end