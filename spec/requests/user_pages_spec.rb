require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_heading('Sign up') }
    it { should have_title('Sign up') }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_heading(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
        it { should have_error_explanation('Password can\'t be blank') }
        it { should have_error_explanation('Name can\'t be blank') }
        it { should have_error_explanation('Email can\'t be blank') }
        it { should have_error_explanation('Email is invalid') }
        it { should have_error_explanation('Password is too short (minimum is 6 characters)') }
        it { should have_error_explanation('Password confirmation can\'t be blank') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.build(:user) }
      before { valid_signup_info(user) }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count)
      end

      describe "after saving the user" do
        before { click_button submit }

        it { should have_title(user.name) }
        it { should have_success_message('Welcome') }
        it { should have_link('Sign out') }

        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end
      end
    end
  end
end
