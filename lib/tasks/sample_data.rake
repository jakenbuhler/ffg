require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    
    # Users
    admin = User.create!(:name => "Example User",
                         :email => "example@railstutorial.org",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)
    7.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    
    # Breweries
    names = ["Allagash", "Lagunitas", "Rogue", "Stone"]
    names.each do |name|
      Brewery.create!(:name => name)
    end
    
    # Beers
    Brewery.all.each do |brewery|
      beer_count = rand(5) + 1
      beer_count.times do
        style = ["Stout", "Ale", "IPA", "Dubel", "Tripel", "Lager"][rand(6)]
        name = Faker::Company.name
        abv = (rand * 10.0 + 2.0).round(2)
        description = Faker::Lorem.sentence
        brewery.beers.create(:style => style,
                             :name => name,
                             :abv => abv,
                             :description => description)
      end
    end
  end
end