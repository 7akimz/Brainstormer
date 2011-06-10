require 'active_support/all'

Factory.define :user do |u|
  u.name            "mohamed"
  u.username        "mohamed"
  u.sequence :email do |e|
    "user#{e}@test.com"
  end
  u.password        "mmmmmm"
  u.address         "nasr city"
  u.country         1
  u.role            2
  u.mobile_number   "0111351995"
  u.spoken_language 1
  #u.teams { |teams| [teams.association(:team)] }
end

Factory.define :team do |t|
  t.sequence :name do |n|
    "team#{n}"
  end
  t.role        0
  t.email       "black_team@example.com"
  #t.users { |users| [users.association(:user)] }
  #t.projects { |projects| [projects.association(:project)] }
end

Factory.define :client do |c|
  c.name    "client"
  c.email   "client@example.com"
  c.contact "0105555555"
  c.address "an example address"
end

Factory.define :project do |p|
  p.name         "graduation"
  p.description  "an example of a description"
  p.location     "Egypt"
  p.budget       1000.0
  p.side_notes   "a side note example"
  p.finished     false
  p.start_date   1.week.ago
  p.due          Time.now
  p.association  :client
  #p.teams { |teams| [teams.association(:team)] }
end

Factory.define :member do |m|
  m.association :user
  m.association :team
end

Factory.define :assignment do |a|
  a.association :team
  a.association :project
end
