# F' ugly patch, just for evading compatiblity issues between
# different versions of net-ldap.
class Fixnum
    def first
        self
    end
end

class SessionsController < Devise::SessionsController

  def create
    super
    	puts "----------------------------------------"
    	puts "INICIO DE SESION"
    	puts "----------------------------------------"
    
    if current_user.gid == nil
        data = Devise::LDAP::Adapter.get_ldap_param(current_user.login,"gidnumber")
        current_user.gid = data.first
    end

    if ((45 == current_user.gid) or (current_user.login == "09-10177") or (current_user.login == "09-10336"))
        if current_user.email == ""
            puts "----------------------------------------"
            puts "AGREGANDO MAIL Y ROL"
            puts "----------------------------------------"
            current_user.email = current_user.login + "@ldc.usb.ve"
            current_user.role = "normal"
            current_user.name = current_user.login
            current_user.lastname = ""
            current_user.save
            flash[:notice] = "Por favor, al ser su primer ingreso al sistema, ingresa a su perfil y modifique su Nombre y Apellido."
        end

    else
        flash[:alert] = "Disculpe, no tiene permisos para acceder."
        current_user.destroy
    
    end
  end
end