class User < ActiveRecord::Base
  
  has_many :members
  has_many :teams, :through => :members
  
  has_many :posts, :dependent => :destroy

  has_many :relationships, :foreign_key => "follower_id", 
    		           :dependent => :destroy

  has_many :following, :through => :relationships, 
	  	       :source => :followed

  has_many :inverted_relationships, :foreign_key => "followed_id",
				    :class_name => "Relationship",
                                    :dependent => :destroy


  has_many :followers, :through => :inverted_relationships,
    		       :source => :follower

  mount_uploader :image, ImageUploader

  USER_ROLE = {
    0 => "Analyst",
    1 => "Developer",
    2 => "Manager",
    3 => "Software Engineer",
    4 => "Team Leader"
  }

  USER_COUNTRY = {
    0 => "Dubai",
    1 => "Egypt",
    2 => "Saudia Arabia", 
    3 => "United Kingdom",
    4 => "United States"
  }

  USER_LANGUAGE = {
    0 => "English",
    1 => "Arabic",
    2 => "French"
  }
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
    :remember_me, :name, :address, :role, :username, :mobile_number,
    :spoken_language, :country, :image

  # Setup user validations for the model
  validates :name,             :presence => true,
                               :length => { :maximum => 50 }

  validates :username,         :presence => true,
                               :uniqueness => true,
                               :length => { :within => 3..30 },
                               :exclusion => { :in => %w(admin 
                                 superuser webmaster) }

  validates :role,             :inclusion => { :in => 0..4 }

  validates :country,          :inclusion => { :in => 0..4 }

  validates :spoken_language,  :inclusion => { :in => 0..2 }

  validates :mobile_number,    :numericality => true,
                               :if => :mobile_present?

  # Check if the mobile number is present
  def mobile_present?
    !mobile_number.nil?
  end
  # get the role name which coressponds to a role number stored
  # in the database 
  def user_role
    USER_ROLE[role]
  end

  # get the country name which coressponds to a country number stored
  # in the database 
  def user_country
    USER_COUNTRY[country]
  end

  # get the language name which coressponds to a language number stored
  # in the database 
  def user_language
    USER_LANGUAGE[spoken_language]
  end

  # convert collection to a double paired array then sort them
  # to use for drop down list data
  def self.collection_name_options(collection)
    if collection == "country"
      USER_COUNTRY.to_a.sort
    elsif collection == "role"
      USER_ROLE.to_a.sort
    elsif collection == "language"
      USER_LANGUAGE.to_a.sort
    end
  end
 
  # Find all the post where id match the given user id
  def feed
    Post.from_users_followed_by(self)
  end

  # Check if a user is following another one
  def following?(followed)
    self.relationships.find_by_followed_id(followed)
  end

  # Follow a User method
  def follow!(followed)
    self.relationships.create!(:followed_id => followed.id)
  end

  # Unfollow User method
  def unfollow!(followed)
    self.relationships.find_by_followed_id(followed).destroy
  end

end
