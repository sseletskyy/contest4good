module ValidatePage

  def login_as_user
    @_user ||= FactoryGirl.create(:user)
    role = Role.new
    role.name = :user
    role.save
    login_as(@_user, scope: :user, run_callbacks: false)
  end

  def login_as_admin
    unless @_admin
      Contest4good::create_roles
      @_admin = FactoryGirl.create(:user)
      @_admin.add_role :admin
    end
    login_as(@_admin, scope: :user, run_callbacks: false)
  end

  def validate_page(args = {})
    check_content args[:content]
    check_flash_errors args[:errors]
  end

  def check_flash_errors(container = nil)
    container ||= "body div.main-content div.alert-danger"
    if selector = page.has_selector?(container)
      unless block_given?
        raise page.find(container).text
      else
        yield(selector)
      end
    end
  end

  def check_content(container = nil)
    container ||= "body div.page-content"
    selector = page.find(container)
    raise "NoContent" if selector.text == ""
    yield(selector) if block_given?
   end
end