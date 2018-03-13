module InputTypes
  module UserInputTypes
    SignUp = GraphQL::InputObjectType.define do
      name 'signUpInputType'
      description 'Input object type for signing up a new user'

      input_field :username, types.String
      input_field :email, !types.String
      input_field :password, !types.String
      input_field :password_confirmation, !types.String
      input_field :provider, types.String
      input_field :uid, types.String
      input_field :device_type, !types.String
      input_field :device_id, !types.String
    end

    ChangePassword = GraphQL::InputObjectType.define do
      name 'changePasswordInputType'
      description 'Input object type for changing password of a user'

      input_field :current_password, !types.String
      input_field :password, !types.String
      input_field :password_confirmation, !types.String
    end

    SignIn = GraphQL::InputObjectType.define do
      name 'signInInputType'
      description 'Input object type for signing in a user'

      input_field :email, !types.String
      input_field :password, types.String
      input_field :provider, types.String
      input_field :uid, types.String
      input_field :device_type, !types.String
      input_field :device_id, !types.String
    end
  end
end
