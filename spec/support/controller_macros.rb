module ControllerMacros
  def login_fixture_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @user = users(:admin)
      sign_in @user
    end
  end

  def login_fixture_librarian
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:librarian]
      @user = users(:librarian1)
      sign_in @user
    end
  end

  def login_fixture_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = users(:user1)
      sign_in @user
    end
  end
end
