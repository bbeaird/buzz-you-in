require 'spec_helper'

describe UsersController do

  describe "GET 'add_phone_number'" do
    it "returns http success" do
      get 'add_phone_number'
      response.should be_success
    end
  end

end
