class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :visitor_passes

  # validates :resident_phone_number, phony_plausible: true, message: "Resident phone number can't be empty!"
  # validates :callbox_phone_number, presence: true
  # validates :resident_byi_phone_number, presence: true
end
