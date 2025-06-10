class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  belongs_to :userable, polymorphic: true, optional: true
  attr_accessor :first_name, :last_name, :speciality, :availibity, :birthday

  has_many :questions, dependent: :destroy
end
