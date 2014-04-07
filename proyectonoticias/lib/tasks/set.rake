namespace :set do
  desc "Crea 3 usuarios: admin@a.a, privi@p.p, norma@n.n"
  task :users => :environment do
		Rake::Task['db:reset'].invoke
		puts 'Creado admin@a.a' unless not User.create(
			:email						=>	"admin@a.a",
			:password					=>	"12345678",
			:role						=>	"admin"
			)
		puts 'Creado privi@p.p' unless not User.create(
			:email						=>	"privi@p.p",
			:password					=>	"12345678",
			:role						=>	"privileged"
			)
		puts 'Creado norma@n.n' unless not User.create(
			:email						=>	"norma@n.n",
			:password					=>	"12345678",
			:role						=>	"normal"
			)

  end

  desc "Crea 3 usuarios"
  task :database => [:users]
end