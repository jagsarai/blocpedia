class User < ActiveRecord::Base
  has_many :wikis, :dependent => :destroy
  has_many :collaborations
  has_many :shared_wikis, through: :collaborations, source: :wikis

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

 validates :username, length: {minimum: 3, maximum: 100}, presence: true

 enum role: [:standard, :premium, :admin]

 after_initialize :set_default_role

 def set_default_role
   self.role ||= :standard
 end

 def avatar_url(size)
   gravatar_id = Digest::MD5::hexdigest(self.email).downcase
   "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
 end

 def is_owner_of?(wiki)
   admin? || wiki.user == self || wiki.new_record?
 end


 protected
 # def confirmation_required?
 #   false
 # end

end
