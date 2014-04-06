class Notifier < ActionMailer::Base
  default from: 'danswerusb@gmail.com'

  def report_notify(user)
    @user = user
    @reports = Report.where(:sent => false)

    for r in @reports do
      if r.sent == false
        r.update_attribute("sent", true)
      end
    end

    mail(:to => @user.email, :subject => "Tienes nuevas noticias que leer")
  end
end
