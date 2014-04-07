class Notifier < ActionMailer::Base
  default from: 'danswerusb@gmail.com'

  def report_notify(user)
    @user = user
    @reports = Report.where(:sent => false)

    mail(:to => @user.email, :subject => "Tienes nuevas noticias que leer")
  end
end
