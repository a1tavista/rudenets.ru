Clearance.configure do |config|
  config.allow_sign_up = false
  config.redirect_url = "/admin"
  config.routes = false
end

Clearance::PasswordsController.layout "admin"
Clearance::UsersController.layout "admin"
Clearance::BaseController.layout "admin"
