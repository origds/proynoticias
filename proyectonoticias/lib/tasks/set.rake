namespace :set do
  desc "Crea 3 usuarios: admin@a.a, privi@p.p, norma@n.n"
  task :users => :environment do
		Rake::Task['db:reset'].invoke
		puts 'Creado admin@a.a' unless not User.create(
			:login		=>	"09-10177",
			:email		=>	"09-10177@ldc.usb.vePRUEBA",
			:role		=>	"admin"
			)
		puts 'Creado privi@p.p' unless not User.create(
			:login		=> 'privi',
			:email		=>	"privi@p.p",
			:password	=>	"12345678",
			:role		=>	"privileged"
			)
		puts 'Creado norma@n.n' unless not User.create(
			:login		=> 'norma',
			:email		=>	"norma@n.n",
			:password	=>	"12345678",
			:role		=>	"normal"
			)

  end

  desc "Crea 3 usuarios"
  task :database => [:users]
end