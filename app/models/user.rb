class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, 
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :student
  has_one :professor
  has_many :reviews, :foreign_key => "student_id"#, :through => :student
  has_many :section_users
  has_many :sections, :through => :section_users
  belongs_to :professor_user

  before_save { self.email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w\-\.]+@(\w+\.)*virginia\.edu\z/i

  validates :email, :presence   => true,
                    :format     => { :with => VALID_EMAIL_REGEX },
                    :uniqueness => { :case_sensitive => false }

  validates_presence_of :first_name #, :last_name

  # Authenticate user based on old MD5-hashed password
  def old_authenticate(password)
    password_salt = ENV["OLD_SALT"]
    old_hash = Digest::MD5.hexdigest(password + password_salt)
    if old_hash == self.old_password
      return self
    else
      return false
    end
  end

  def migrate(password)
    self.password = password
    self.password_confirmation = password
    self.old_password = nil
    self.save
    return self      
  end

end
