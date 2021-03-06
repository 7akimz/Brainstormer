require 'active_support/all'

Factory.define :user do |u|
  u.name            "mohamed"
  u.sequence :username do |n|
    "user#{n}"
  end
  u.sequence :email do |e|
    "user#{e}@test.com"
  end
  u.password        "mmmmmm"
  u.address         "nasr city"
  u.country         1
  u.role            0
  u.mobile_number   "0111351995"
  u.spoken_language 1
end

Factory.define :team do |t|
  t.sequence :name do |n|
    "team#{n}"
  end
  t.role        0
  t.email       "black_team@example.com"
end

Factory.define :company do |c|
  c.sequence(:name) { |n| "company#{n}" }
  c.sequence(:email) { |e| "company#{e}@company.com" }
  c.telephone  "224015819"
  c.country    1
  c.address    "my company address"
  c.capital    10000
end

Factory.define :project do |p|
  p.sequence(:name) { |n| "graduation#{n}" }
  p.description  "an example of a description"
  p.address      "Egypt"
  p.budget       1000.0
  p.side_notes   "a side note example"
  p.finished     false
  p.start_date   1.week.ago
  p.due          Date.today
end

Factory.define :task do |t|
  t.association :project
  t.sequence(:name) { |n| "task#{n}" }
  t.description "very long description"
  t.priority    1
  t.progress    25.0
  t.start_date  2.days.ago
  t.due         Date.today
end

Factory.define :member do |m|
  m.association :user
  m.association :team
end

Factory.define :assignment do |a|
  a.association :team
  a.association :project
end

Factory.define :worker do |w|
  w.association :team
  w.association :company
end

Factory.define :post do |p|
  p.content     "Lorem example content preloaded in the...."
  p.association :user
end

Factory.define :comment do |c|
  c.name        "comment"
  c.description "new comment"
  c.association :task
end
