# User model used for authentication by Devise
class User < ApplicationRecord
  # Use slugs instead of DB IDs in URLs
  include FriendlyId

  mount_uploader :avatar, AvatarUploader

  friendly_id :full_name, use: :slugged

  acts_as_voter
  
  # Roles used by the authorization setup
  enum role: { user: 0, admin: 1 }
  attr_accessor :summary, :description
  


  # **We should NOT validate e-mail uniqueness, e-mail regex or password
  # confirmation here**. Devise's Validatable module is enabled so it already
  # validates those attributes (in the registerable form and the user management
  # form in the admin namespace). Validating again here will produce duplicated
  # error messages.

  validates :first_name, :last_name, presence: true
  # Custom password strength validation
  validate :password_strength

  # Callback to set the default role of new records
  after_initialize :set_default_role, if: :new_record?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  devise :omniauthable, omniauth_providers: [:facebook , :google_oauth2, :twitter]

  has_many :posts
  has_one :profile 
  has_many :items
  has_many :pics
  has_many :videos
  has_many :tokens

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :messages, :class_name => "Message", :foreign_key => "user_id"
  has_many :rooms, :foreign_key => "sender_id"

  has_many :notifications, foreign_key: :recipient_id

  has_many :tags, :through => :taggings, :foreign_key => "creator_id"

  has_many :friends_posts, through: :friends, source: :posts


  

  after_create do 
    p = Profile.new 
    p.user_id = self.id 
    p.title = self.full_name
    p.description = self.full_name + " Profile description."
    p.save
  end


  # Allow a single Ransack search field to search the virtual attr 'full_name'
  # If first_name is 'John' and last_name is 'Doe', this will enable us to
  # search for 'John', 'Doe' or 'John Doe' using the 'cont' predicate.
  # See https://github.com/activerecord-hackery/ransack/wiki/using-ransackers
  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new(
      '||',
      Arel::Nodes::InfixOperation.new(
        '||',
        parent.table[:first_name],
        Arel::Nodes.build_quoted(' ')
      ),
      parent.table[:last_name]
    )
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def remaining_token_limit
    note = 5 - self.tokens.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, token_type: 'Note').count || 3
    debate = 5 - self.tokens.where( created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, token_type: 'Debate').count || 5
    question = 5 - self.tokens.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day, token_type: 'Question').count || 6
    [ note > 0 ? note : 0 , debate > 0 ? debate : 0 ,  question > 0 ? question : 0]
  end

  def current_tokens
    self.tokens.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
  end


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      
      if auth.provider == :facebook
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name 
        user.first_name = auth.info.name.split(' ').first 
        user.last_name = auth.info.name.split(' ').last 
        user.image = auth.info.image # assuming the user model has an image
      elsif auth.provider == :google_oauth2
        user.token = auth.credentials.token
        user.expires = auth.credentials.expires
        user.expires_at = auth.credentials.expires_at
        user.refresh_token = auth.credentials.refresh_token
      end
    end
  end

  # def display_pic
  #   if self.image.blank?
  #     self.profile
  # end

  private

  def set_default_role
    # self.my_enum ||= :default_value does not work as it does not apply
    # the default value if the controller passes "nil" as a value for the enum.
    self.role = :user if role.blank?
  end


  # TODO: extract this to a validator class
  def password_strength
    # minimum_length = 8
    # # Regex matches at least one lower case letter, one uppercase and one digit
    # complexity_regex = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/
    # # When a user is updated but not its password, the password param is nil
    # if password.present? &&
    #    (password.length < minimum_length || !password.match(complexity_regex))
    #   errors.add :password, :weak_password
    # end
  end

end
