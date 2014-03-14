require "spec_helper"

describe A::AdminProfilesController do
  describe "routing" do

    it "routes to #index" do
      get("/a/admin_profiles").should route_to("a/admin_profiles#index")
    end

    it "routes to #index.json" do
      get("/a/admin_profiles.json").should route_to("a/admin_profiles#index", format: 'json')
    end

    it "routes to #show" do
      get("/a/admin_profile").should route_to("a/admin_profiles#show")
    end

    it "routes to #edit" do
      get("/a/admin_profile/edit").should route_to("a/admin_profiles#edit")
    end

    it "routes to #update" do
      put("/a/admin_profile").should route_to("a/admin_profiles#update")
    end

    #it "routes to #destroy" do
    #  delete("/a/admin_profiles/1").should route_to("a/admin_profiles#destroy", :id => "1")
    #end

  end
end
