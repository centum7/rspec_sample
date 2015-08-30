require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    describe "with invalid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
                fill_in "Email",with:user.email.upcase
                fill_in "Password",with:user.Password
                click_button "Sign in"
            end

        it { should have_title(user.name) }
        it { should have_content('Sign in') }
        it { should have_title('Sign in') }
        it { should_not have_link('Sign in',)}
    end
  end
end