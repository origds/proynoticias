namespace :set do
  desc "Crea 4 usuarios: Alberto Cols, Oriana Gomez, Carlos Perez, Edna Ruckhaus"
  task :users => :environment do
		Rake::Task['db:reset'].invoke
		puts 'Creado Alberto Cols Admin' unless not User.create(
			:login		=>	"09-10177",
			:email		=>	"09-10177@ldc.usb.ve",
			:role		=>	"admin"
			)
		puts 'Creado Oriana Gomez Admin' unless not User.create(
			:login		=>	"09-10336",
			:email		=>	"09-10336@ldc.usb.ve",
			:role		=>	"admin"
			)
		puts 'Creado Carlos Perez Admin' unless not User.create(
			:login		=> "caperez",
			:email		=> "caperez@ldc.ubs.ve",
			:role		=> "admin"
			)
		puts 'Creado Edna Ruckhaus Admin' unless not User.create(
			:login		=> "ruckhaus",
			:email		=> "ruckhaus@ldc.usb.ve",
			:role		=> "admin"
			)
  end

  desc "Crea 4 usuarios"
  task :database => [:users]
end