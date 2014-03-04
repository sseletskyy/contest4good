require "spec_helper"

describe U::UserProfilesController do
  describe "routing" do

    it "routes to #index" do
      get("/u/user_profiles").should route_to("u/user_profiles#index")
    end

    it "routes to #new" do
      get("/u/user_profiles/new").should route_to("u/user_profiles#new")
    end

    it "routes to #show" do
      get("/u/user_profiles/1").should route_to("u/user_profiles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/u/user_profiles/1/edit").should route_to("u/user_profiles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/u/user_profiles").should route_to("u/user_profiles#create")
    end

    it "routes to #update" do
      put("/u/user_profiles/1").should route_to("u/user_profiles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/u/user_profiles/1").should route_to("u/user_profiles#destroy", :id => "1")
    end

  end
end
