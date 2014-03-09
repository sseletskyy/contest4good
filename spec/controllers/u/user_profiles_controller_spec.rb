require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe U::UserProfilesController do

  # This should return the minimal set of attributes required to create a valid
  # UserProfile. As you add validations to UserProfile, be sure to
  # adjust the attributes here as well.
  login_user

  let(:valid_attributes) { {"first_name" => "I", 'middle_name' => 'O', 'last_name' => 'F'} }
  let(:valid_session) { {} }

  #describe "GET index" do
  #  it "assigns all user_profiles as @user_profiles" do
  #    user_profile = @current_user.user_profile
  #    get :index, {}, valid_session
  #    assigns(:user_profiles).should eq([user_profile])
  #  end
  #end

  describe "GET show" do
    it "assigns the requested user_profile as @user_profile" do
      user_profile = @current_user.user_profile
      get :show, {:id => user_profile.to_param}, valid_session
      assigns(:user_profile).should eq(user_profile)
    end
  end

  describe "GET edit" do
    it "assigns the requested user_profile as @user_profile" do
      user_profile = @current_user.user_profile
      get :edit, {:id => user_profile.to_param}, valid_session
      assigns(:user_profile).should eq(user_profile)
    end
  end

  describe "PUT update" do
    let(:user_profile) { @current_user.user_profile }
    describe "with valid params" do
      it "updates the requested user_profile" do
        UserProfile.any_instance.should_receive(:update).with({"first_name" => "Z"})
        put :update, {:id => user_profile.to_param, :user_profile => {"first_name" => "Z"}}, valid_session
      end

      it "assigns the requested user_profile as @user_profile" do
        put :update, {:id => user_profile.to_param, :user_profile => valid_attributes}, valid_session
        assigns(:user_profile).should eq(user_profile)
      end

      it "redirects to the user_profile" do
        put :update, {:id => user_profile.to_param, :user_profile => valid_attributes}, valid_session
        response.should redirect_to u_home_path
      end
    end

    describe "with invalid params" do
      it "assigns the user_profile as @user_profile" do
        # Trigger the behavior that occurs when invalid params are submitted
        UserProfile.any_instance.stub(:save).and_return(false)
        put :update, {:id => user_profile.to_param, :user_profile => {"user_id" => "invalid value"}}, valid_session
        assigns(:user_profile).should eq(user_profile)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        UserProfile.any_instance.stub(:save).and_return(false)
        put :update, {:id => user_profile.to_param, :user_profile => {"user_id" => "invalid value"}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  #describe "DELETE destroy" do
  #  it "destroys the requested user_profile" do
  #    user_profile = UserProfile.create! valid_attributes
  #    expect {
  #      delete :destroy, {:id => user_profile.to_param, namespace: 'u'}, valid_session
  #    }.to change(UserProfile, :count).by(-1)
  #  end
  #
  #  it "redirects to the user_profiles list" do
  #    user_profile = UserProfile.create! valid_attributes
  #    delete :destroy, {:id => user_profile.to_param}, valid_session
  #    response.should redirect_to(u_user_profiles_url)
  #  end
  #end

end