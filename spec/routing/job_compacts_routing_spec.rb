require "spec_helper"

describe JobCompactsController do
  describe "routing" do

    it "routes to #index" do
      get("/job_compacts").should route_to("job_compacts#index")
    end

    it "routes to #new" do
      get("/job_compacts/new").should route_to("job_compacts#new")
    end

    it "routes to #show" do
      get("/job_compacts/1").should route_to("job_compacts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/job_compacts/1/edit").should route_to("job_compacts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/job_compacts").should route_to("job_compacts#create")
    end

    it "routes to #update" do
      put("/job_compacts/1").should route_to("job_compacts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/job_compacts/1").should route_to("job_compacts#destroy", :id => "1")
    end

  end
end
