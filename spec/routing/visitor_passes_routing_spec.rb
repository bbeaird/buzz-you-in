require "spec_helper"

describe VisitorPassesController do
  describe "routing" do

    it "routes to #index" do
      get("/visitor_passes").should route_to("visitor_passes#index")
    end

    it "routes to #new" do
      get("/visitor_passes/new").should route_to("visitor_passes#new")
    end

    it "routes to #show" do
      get("/visitor_passes/1").should route_to("visitor_passes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/visitor_passes/1/edit").should route_to("visitor_passes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/visitor_passes").should route_to("visitor_passes#create")
    end

    it "routes to #update" do
      put("/visitor_passes/1").should route_to("visitor_passes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/visitor_passes/1").should route_to("visitor_passes#destroy", :id => "1")
    end

  end
end
