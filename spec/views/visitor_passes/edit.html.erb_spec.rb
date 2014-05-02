require 'spec_helper'

describe "visitor_passes/edit" do
  before(:each) do
    @visitor_pass = assign(:visitor_pass, stub_model(VisitorPass,
      :visitor_phone_number => "MyString",
      :active => false,
      :used => false
    ))
  end

  it "renders the edit visitor_pass form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => visitor_passes_path(@visitor_pass), :method => "post" do
      assert_select "input#visitor_pass_visitor_phone_number", :name => "visitor_pass[visitor_phone_number]"
      assert_select "input#visitor_pass_active", :name => "visitor_pass[active]"
      assert_select "input#visitor_pass_used", :name => "visitor_pass[used]"
    end
  end
end
