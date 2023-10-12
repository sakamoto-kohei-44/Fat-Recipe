module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      build_resource(sign_up_params)
      resource.skip_special_validation = true
      super
    end
  end
end
