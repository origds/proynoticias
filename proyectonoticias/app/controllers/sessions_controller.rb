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
  end

end
