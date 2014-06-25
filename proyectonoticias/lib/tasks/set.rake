namespace :set do
  desc "Crea 4 usuarios: Alberto Cols, Oriana Gomez, Carlos Perez, Edna Ruckhaus"
  task :users => :environment do
		Rake::Task['db:reset'].invoke
		puts 'Creado Alberto Cols Admin' unless not User.create(
			:login		=>	"09-10177",
			:email		=>	"09-10177@ldc.usb.ve",
			:role		=>	"admin",
			:name 		=>	"Alberto",
			:lastname	=>	"Cols",
			)
		puts 'Creado Oriana Gomez Admin' unless not User.create(
			:login		=>	"09-10336",
			:email		=>	"09-10336@ldc.usb.ve",
			:role		=>	"admin",
			:name 		=>	"Oriana",
			:lastname	=>	"Gomez",
			)
		puts 'Creado Carlos Perez Admin' unless not User.create(
			:login		=> "caperez",
			#:email		=> "caperez@ldc.usb.ve",
			:role		=> "admin",
			)
		puts 'Creado Edna Ruckhaus Admin' unless not User.create(
			:login		=> "ruckhaus",
			#:email		=> "ruckhaus@ldc.usb.ve",
			:role		=> "admin",
			)
		puts 'Creado Jackney Alba (Secretaria) Admin' unless not User.create(
			:login		=> "secret-depci",
			:email		=> "secret-depci@ldc.usb.ve",
			:role		=> "admin",
			:name 		=>	"Jackney",
			:lastname	=>	"Alba",
			)
		puts 'Creado Zulay Rodriguez (Secretaria) Admin' unless not User.create(
			:login		=> "asist-depci",
			:email		=> "asist-depci@ldc.usb.ve",
			:role		=> "admin",
			:name 		=>	"Zulay",
			:lastname	=>	"Rodriguez",
			)
  end

  desc "Crea 6 usuarios"
  task :database => [:users]
end