# Se define el task a ejecutar por el rake para el envio de correos utilizando cron

namespace :email do
  desc "Envia el boletin informativo a todos los usuarios"
  task :send => :environment do 
    @user = User.all

    for usu in @user do
      Notifier.report_notify(usu).deliver    
    end
  end
end