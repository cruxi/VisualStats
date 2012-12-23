require "spec_helper"

describe BuildCompactsController do
  describe "routing" do

    it "routes to #index" do
      get("/build_compacts").should route_to("build_compacts#index")
    end

    it "routes to #new" do
      get("/build_compacts/new").should route_to("build_compacts#new")
    end

    it "routes to #show" do
      get("/build_compacts/1").should route_to("build_compacts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/build_compacts/1/edit").should route_to("build_compacts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/build_compacts").should route_to("build_compacts#create")
    end

    it "routes to #update" do
      put("/build_compacts/1").should route_to("build_compacts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/build_compacts/1").should route_to("build_compacts#destroy", :id => "1")
    end

  end
end
