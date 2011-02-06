# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Jacob Rothenbuhler"
  user.email                 "rothenbuhler@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.define :brewery do |brewery|
  brewery.name "Lagunitas"
end

Factory.define :beer do |beer|
  beer.association :brewery
  beer.style       "Ale"
  beer.name        "Brown Shugga"
  beer.abv         9.99
  beer.description "As good as it sounds!"
end