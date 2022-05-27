# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#create teams
(0..10).each {|number| Team.create(name: "Team #{number}")}

#create users 
(0..30).each { User.create(name: Faker::Name::first_name, last_name: Faker::Name::last_name, email: Faker::Internet.email, id_number: Faker::IDNumber.valid, framework: ['Java', 'C++', 'C#'].sample, password: '123456'  )}

#asign member to teams
Team.all.each do |team|
    number = [1,2,3].sample
    (0...number).each{ Member.with_no_team.sample.update(team_id: team.id) if Member.with_no_team.present? }
end




