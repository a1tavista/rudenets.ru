Clearance.configure do |config|
  config.allow_sign_up = false
  config.routes = true
end

Clearance::PasswordsController.layout "admin"
Clearance::UsersController.layout "admin"
Clearance::BaseController.layout "admin"
