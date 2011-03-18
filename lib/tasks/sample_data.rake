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
    3.times do |n|
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
      beer_count = rand(3) + 1
      beer_count.times do
        style = ["Stout", "Ale", "IPA", "Dubel", "Tripel", "Lager"][rand(6)]
        name = Faker::Company.name
        abv = (rand * 10.0 + 2.0).round(2)
        description = Faker::Lorem.paragraph
        brewery.beers.create!(:style => style,
                              :name => name,
                              :abv => abv,
                              :description => description)
      end
    end

    # Tastings
    Beer.all.each do |beer|
      User.all.each do |taster|
        rating = rand(5) + 1
        comments = Faker::Lorem.sentence
        tasted_on = Date.new(rand(4) + 2008, rand(12) + 1, rand(28) + 1)
        Tasting.create!(:beer_id => beer.id,
                        :taster_id => taster.id,
                        :rating => rating,
                        :comments => comments,
                        :tasted_on => tasted_on)
      end
    end
  end
end