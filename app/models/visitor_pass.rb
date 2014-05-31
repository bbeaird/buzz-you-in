class VisitorPass < ActiveRecord::Base
  belongs_to :user
  before_save :format_visitor_phone_number

  protected
    def format_visitor_phone_number
      unless self.visitor_phone_number.blank?
        self.visitor_phone_number = self.visitor_phone_number.gsub(/\D/, '')
      end
    end
end
