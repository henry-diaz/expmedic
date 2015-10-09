namespace :default_data do
  desc 'Loads default data into database'
  task load: :environment do |tsk, args|

    ###########################################

    Admin.where(email: 'admin@expmedic.com', username: 'admin').first_or_create(password: 'expmedic', role: 'admin', firstname: 'Administrador', lastname: 'ExpMedic')
  end
end
