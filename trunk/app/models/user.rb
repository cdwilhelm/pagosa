class User < ActiveRecord::Base

  require 'digest/sha1'

  has_many :notice

  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :login
  validates_uniqueness_of :login
  attr_accessor :password_confirmation
  #  attr_accessor :password
  validates_confirmation_of :password
  def validate
    errors.add_to_base("Missing password" ) if hashed_password.blank?
  end

  private
  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt # 'wibble' makes it harder to guess
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(@password, self.salt)
  end

  def self.authenticate(login, password)
    user = self.find_by_login(login)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  def anonymous?
    self.name.nil?
  end

  def self.anonymous
    @anonymous ||= User.find :first, :conditions => "users.name is null"
  end
  
  def logged_in?
    self.name
  end
end
