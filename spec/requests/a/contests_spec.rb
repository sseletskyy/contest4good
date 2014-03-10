require 'spec_helper'

describe "Contests" do
  describe "GET a/contests" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get a_contests_path
      response.status.should == be_in([200, 302])
    end
  end
end
