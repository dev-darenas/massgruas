class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  belongs_to :enterprise, autosave: true

  enum rol: { admin: 'Admin', mananger: 'Mananger', activated: 'Activated'}
end
