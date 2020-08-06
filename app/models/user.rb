class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  belongs_to :enterprise, autosave: true
  has_many :observations
  validates :email, uniqueness: { case_sensitive: false }
  enum rol: { admin: 'Admin', mananger: 'Mananger', activated: 'Activated'}
  before_save :to_upper


  def to_upper
    self.fullname.try(:upcase!)
  end
end
