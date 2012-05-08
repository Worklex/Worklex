class Task < ActiveRecord::Base
  acts_as_gmappable

  def gmaps4rails_address
    #"#{self.street}, #{self.city}, #{self.country}"
    "Lviv"
  end

  belongs_to :user, :foreign_key => "owner_id"

  has_many :assignments
  has_many :tasks, :through => :assignments

  validates :title, :presence => true
  validates :text, :presence => true
  validates :owner_id, :presence => true
  
  validates_length_of :title, :maximum => 128
  validates_length_of :text, :maximum => 256

  def self.by_user(user)
    if user
      where(:owner_id => user.id)
    end
  end

  def self.search_by(options)
    search_by_title_or_text(options, options)
  end

  def is_owner?(user)
    owner_id == user.id if user
  end

end
