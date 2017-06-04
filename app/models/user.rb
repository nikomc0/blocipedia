class User < ActiveRecord::Base
  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :shared_wikis, through: :collaborators, source: :wiki

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save { self.role ||= :standard }

  enum role: [:standard, :premium, :admin]
end
