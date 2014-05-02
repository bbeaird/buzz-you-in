require 'spec_helper'

describe "visitor_passes/index" do
  before(:each) do
    assign(:visitor_passes, [
      stub_model(VisitorPass,
        :visitor_phone_number => "Visitor Phone Number",
        :active => false,
        :used => false
      ),
      stub_model(VisitorPass,
        :visitor_phone_number => "Visitor Phone Number",
        :active => false,
        :used => false
      )
    ])
  end

  it "renders a list of visitor_passes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Visitor Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
