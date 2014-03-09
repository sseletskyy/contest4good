require "spec_helper"

describe U::UserProfilesController do
  describe "routing" do

    it "routes to #show" do
      get("/u/user_profile").should route_to("u/user_profiles#show")
    end

    it "routes to #edit" do
      get("/u/user_profile/edit").should route_to("u/user_profiles#edit")
    end

    it "routes to #update" do
      put("/u/user_profile").should route_to("u/user_profiles#update")
    end

    #it "routes to #destroy" do
    #  delete("/u/user_profiles/1").should route_to("u/user_profiles#destroy", :id => "1")
    #end

  end
end
