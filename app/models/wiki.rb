class Wiki < ActiveRecord::Base
  belongs_to :user
  belongs_to :edited_by, :class_name => "User"
  has_many :collaborations
  has_many :users, through: :collaborations

  default_scope {order('updated_at DESC')}

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :user, presence: true

end
