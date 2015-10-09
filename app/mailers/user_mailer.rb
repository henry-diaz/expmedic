class UserMailer < ApplicationMailer
  default from: 'no-reply@expmedic.com'
 
  def welcome_email(clinic, generated_password)
    @clinic = clinic
    @generated_password = generated_password
    mail(to: @clinic.email, subject: 'Bienvenido/a a ExpMedic')
  end
end
