require 'factory_girl'


#FactoryGirl.sequence :num do |n|
#    "#{n}"
#end

#sequence :num do |n|
#  "#{n}"
#end


FactoryGirl.define do
  sequence :first_name do |n|
    "#{Faker::Name.first_name} #{n}"
  end
  sequence :last_name do |n|
    "#{Faker::Name.last_name} #{n}"
  end
  sequence :name do |n|
    "#{Faker::Lorem.sentence(3)} #{n}"
  end
  sequence :addr_street do |n|
    "#{Faker::Address.street_address}"
  end
  sequence :addr_postcode do |n|
    "#{Random.rand(999)}"
  end
  sequence :addr_city do |n|
    "#{Faker::Address.city}"
  end
  sequence :phone_number do |n|
    "049#{Random.rand(9999999)}"
  end
  sequence :description do |n|
    "#{Faker::Lorem.sentence(10)}"
  end



  factory :user do
    first_name
    last_name
    username { "#{first_name}.#{last_name}" }
    email { "#{username}@example.com".downcase.delete(' ') }
    password "12345678"
    password_confirmation "12345678"
    date_of_birth  "1990-01-01"
    addr_street
    addr_city
    addr_postcode
    phone_number

    confirmation_token "0"
    unconfirmed_email false
    confirmed_at "2000-01-01"
  end

  factory :organization do
    name
    email { "#{name}@example.com".downcase.delete(' ') }
    addr_street
    addr_postcode
    addr_city
    phone_number
    description
  end

end


class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection