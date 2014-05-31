class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :visitor_passes
  before_update :format_resident_phone_number, :format_callbox_phone_number

  # validates :callbox_phone_number, presence: true
  # validates :resident_byi_phone_number, presence: true

  protected
    def format_resident_phone_number
      unless self.resident_phone_number.nil?
        self.resident_phone_number = self.resident_phone_number.gsub(/\D/, '')
      end
    end

    def format_callbox_phone_number
      unless self.callbox_phone_number.nil?
        self.callbox_phone_number = self.callbox_phone_number.gsub(/\D/, '')
      end
    end
end
