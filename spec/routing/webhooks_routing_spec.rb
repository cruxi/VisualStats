require "spec_helper"

describe WebhooksController do
  describe "webhook callback route" do
    it "routes to " do
       post("/drblinken/VisualStats/notify").should route_to("webhooks#notify", username: "drblinken", repository: "VisualStats")
    end
  end
end
