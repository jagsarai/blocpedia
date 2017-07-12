class Wiki < ActiveRecord::Base
  belongs_to :user
  belongs_to :edited_by, :class_name => "User"

  default_scope {order('updated_at DESC')}

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :user, presence: true

  def self.private
    where(:private => true)
  end

  def self.public
    where(:private => false)
  end

end
