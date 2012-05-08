class User < ActiveRecord::Base
  include Clearance::User
  is_gravtastic :default => "retro"

  has_many :assignments
  has_many :tasks, :through => :assignments
  
  attr_accessible :handle, :password_confirmation, :password, :email
  attr_accessible :handle, :website, :location, :bio

  before_validation :regenerate_token, :if => :email_changed?, :on => :update
  before_create :generate_api_key
  #after_update :deliver_email_reset, :if => :email_reset

  validates_uniqueness_of :handle, :allow_nil => true
  validates_format_of :handle, :with => /\A[A-Za-z][A-Za-z_\-0-9]*\z/, :allow_nil => true
  validates_length_of :handle, :within => 3..15, :allow_nil => true

  def self.authenticate(who, password)
    if user = find_by_email(who) || find_by_handle(who)
      user if user.authenticated?(password)
    end
  end

  def self.find_by_slug!(slug)
    find_by_id(slug) || find_by_handle!(slug)
  end

  def name
    handle || email
  end

  def display_handle
    handle || "##{id}"
  end

  def display_id
    handle || id
  end

  def reset_api_key!
    generate_api_key && save!
  end

  def as_json(options={})
    { 'email' => email }
  end

  def to_yaml(*args)
    { 'email' => email }.to_yaml(*args)
  end

  def regenerate_token
    self.email_reset = true
    generate_confirmation_token
  end

  def deliver_email_reset
    Mailer.email_reset(self).deliver
  end

  def generate_api_key
    self.api_key = ActiveSupport::SecureRandom.hex(16)
  end

  def confirm_email!
    self.email_confirmed    = true
    self.confirmation_token = self.email_reset = nil
    save(:validate => false)
  end

end
