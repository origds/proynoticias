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

    non_45_users = [
        "09-10177",
        "09-10336",
        "secret-depci",
        "asist-depci"
    ]

	puts "----------------------------------------"
	puts "INICIO DE SESION"
	puts "----------------------------------------"

    if current_user.gid.nil?
        data = Devise::LDAP::Adapter.get_ldap_param(current_user.login,"gidnumber")
        current_user.gid = data.first
    end

    if (current_user.gid == 45 or non_45_users.include?(current_user.login))
        if current_user.email == ""
            puts "----------------------------------------"
            puts "AGREGANDO MAIL Y ROL"
            puts "----------------------------------------"
            current_user.email = current_user.login + "@ldc.usb.ve"
            if current_user.role != "admin"
                current_user.role = "normal"
            end
            current_user.name = Devise::LDAP::Adapter.get_ldap_param(current_user.login,"givenname").first
            current_user.lastname = Devise::LDAP::Adapter.get_ldap_param(current_user.login,"sn").first
            current_user.save
            flash[:notice] = "Por favor, al ser su primer ingreso al sistema, ingresa a su perfil y modifique su Nombre y Apellido."
        end

    else
        flash[:alert] = "Disculpe, no tiene permisos para acceder."
        current_user.destroy
    
    end
  end
end