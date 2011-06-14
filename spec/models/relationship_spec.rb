require 'spec_helper'

describe Relationship do
  
	before(:each) do
		@follower = Factory(:user)
		@followed = Factory(:user, :email => "new@usr.com",
												:username => "abd el hakim")
		@relationship = @follower.relationships.build(:followed_id => @followed.id)
	end

	it "should create the relationship given valid attributes" do
		@relationship.save!.should be_true
	end

	context "follow action" do

		before(:each) do
			@relationship.save
		end

		it "should have a follower attribute" do
			@relationship.should respond_to(:follower)
		end

		it "should have the right follower" do
			@relationship.follower.should == @follower
		end

		it "should have a followed attribute" do
			@relationship.should respond_to(:followed)
		end

		it "should have the right followed" do
			@relationship.followed.should == @followed
		end
	end

	context "validations" do

		it "should have a follower_id" do
			@relationship.follower_id = nil
			@relationship.should_not be_valid
		end

		it "should have a followed_id" do
			@relationship.followed_id = nil 
			@relationship.should_not be_valid
		end

	end

end
