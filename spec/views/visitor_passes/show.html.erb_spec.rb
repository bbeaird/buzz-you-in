require 'spec_helper'

describe "visitor_passes/show" do
  before(:each) do
    @visitor_pass = assign(:visitor_pass, stub_model(VisitorPass,
      :visitor_phone_number => "Visitor Phone Number",
      :active => false,
      :used => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Visitor Phone Number/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
