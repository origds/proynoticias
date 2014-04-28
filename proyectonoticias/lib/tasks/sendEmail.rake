# Se define el task a ejecutar por el rake para el envio de correos utilizando cron

namespace :email do
  desc "Envia el boletin informativo a todos los usuarios"
  task :send => :environment do 
    @reports = Report.where(:sent => false)
    if @reports.count != 0

      @user = User.all

      for u in @user do
        Notifier.report_notify(u).deliver    
      end

      for r in @reports do
        r.update_attribute("sent", true)
      end
    end
  end
end