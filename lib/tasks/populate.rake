require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    50.times do |n|
      User.create!(:first_name => Faker::Name.first_name,
                   :last_name => Faker::Name.last_name,
                   :email => Faker::Internet.email,
                   :addr_street => Faker::Address.street_address,
                   :addr_postcode => Faker::Address.postcode,
                   :addr_city => Faker::Address.city,
                   :password => "abcdefgh")
    end
    50.times do |n|
      Organization.create!(:name => Faker::Company.name,
                   :email => Faker::Internet.email,
                   :addr_street => Faker::Address.street_address,
                   :addr_postcode => Faker::Address.postcode,
                   :addr_city => Faker::Address.city,
                   :vat_number => Faker::Base.regexify(/^[A-Z0-9]9$/),
                   :site_url => Faker::Internet.domain_name,
                   :facebook_url => "www.facebook.com/"+Faker::Internet.user_name,
                   :description => Faker::Lorem.sentence(30))
    end
  end
end