# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
	name:'nino',
	email: 'ninoko1995@yahoo.co.jp',
	password: 'ninoninomiyamiya1995',
	introduction: '管理者アカウントです'
	)


20.times do |i|
	User.create!(
		name:"#{i}#{i}",
		email: "#{i}@#{i}",
		password: "#{i}#{i}#{i}#{i}#{i}#{i}",
		introduction: "週に#{i}冊は本読んでます！よろしくお願いします！"
	 )
end