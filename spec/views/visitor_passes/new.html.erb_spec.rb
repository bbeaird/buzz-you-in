require 'spec_helper'

describe "visitor_passes/new" do
  before(:each) do
    assign(:visitor_pass, stub_model(VisitorPass,
      :visitor_phone_number => "MyString",
      :active => false,
      :used => false
    ).as_new_record)
  end

  it "renders new visitor_pass form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => visitor_passes_path, :method => "post" do
      assert_select "input#visitor_pass_visitor_phone_number", :name => "visitor_pass[visitor_phone_number]"
      assert_select "input#visitor_pass_active", :name => "visitor_pass[active]"
      assert_select "input#visitor_pass_used", :name => "visitor_pass[used]"
    end
  end
end
