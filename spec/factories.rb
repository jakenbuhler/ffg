# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Jacob Rothenbuhler"
  user.email                 "rothenbuhler@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.define :brewery do |brewery|
  brewery.name "Brauhaus"
end