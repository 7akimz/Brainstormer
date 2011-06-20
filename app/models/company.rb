class Company < ActiveRecord::Base

  # Company association with the Team model through Workers model
  has_many :workers, :dependent => :destroy
  has_many :teams, :through => :workers, :uniq => true
  
  # Regular expression for email validation
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Company model validations
  validates :name,      :presence => true,
                        :uniqueness => true,
                        :length => { :maximum => 50 }

  validates :email,     :presence => true,
                        :format => { :with => EMAIL_REGEX },
                        :uniqueness => { :case_sensitive => false }

  validates :address,   :presence => true

  validates :telephone, :presence => true,
                        :numericality => true 


  validates :capital,   :presence => true,
                        :numericality => true

end
