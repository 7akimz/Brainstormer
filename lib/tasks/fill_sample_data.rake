require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    fill_users
  end
end

def fill_users

    admin = User.create!(
      :name => "mohamed ahmed",
      :username => "mohammed",
      :email => "7akimz@gmail.com",
      :password => "mohamed",
      :address => "nasr city",
      :country => 1,
      :role => 2,
      :mobile_number => "0111351995",
      :spoken_language => 1
    )
    admin.toggle!(:admin)

    99.times do |n|
      name = Faker::Name.name
      username = "sample#{n}"
      email = "sample#{n}@example.com"
      User.create!(
        :name => name,
        :username => username,
        :email => email,
        :password => "password",
        :address => "nasr city",
        :country => 1,
        :role => 1,
        :spoken_language => 1
      )
    end
end

def fill_posts
  User.all(:limit => 10).each do |user|
    50.times do
      content = Faker::Lorem.sentence(5)
      user.posts.create!(:content => content)
    end
  end
end

def fill_relationships
  users = User.all
  user = user.first
  following = users[1..75]
  followers = users[5..25]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end
