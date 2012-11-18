require "spec_helper"

describe BroadcastsController do
  describe "routing" do

    it "routes to #index" do
      get("/broadcasts").should route_to("broadcasts#index")
    end

    it "routes to #new" do
      get("/broadcasts/new").should route_to("broadcasts#new")
    end

    it "routes to #show" do
      get("/broadcasts/1").should route_to("broadcasts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/broadcasts/1/edit").should route_to("broadcasts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/broadcasts").should route_to("broadcasts#create")
    end

    it "routes to #update" do
      put("/broadcasts/1").should route_to("broadcasts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/broadcasts/1").should route_to("broadcasts#destroy", :id => "1")
    end

  end
end
