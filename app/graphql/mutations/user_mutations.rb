module Mutations
  module UserMutations
    SignUp = GraphQL::Relay::Mutation.define do
      name 'signUp'
      description 'User sign up'

      input_field :sign_up, InputTypes::UserInputTypes::SignUp

      return_field :user, Types::UserType
      return_field :userDevice, Types::UserDeviceType
      return_field :messages, types[Types::FieldErrorType]

      resolve lambda { |_obj, inputs, _ctx|
        user = User.new(inputs[:sign_up].to_h.symbolize_keys
                    .slice(:username, :email, :password, :password_confirmation))
        user_device = UserDevice.new(inputs[:sign_up].to_h.symbolize_keys
                                .slice(:device_id, :device_type, :provider, :uid))
        if user.save && user_device.save
          user_device.update(user: user)
          user_device.generate_jwt_token!
          { user: user, userDevice: user_device }
        else
          { messages: user.fields_errors + user_device.fields_errors }
        end
      }
    end

    Update = GraphQL::Relay::Mutation.define do
      name 'updateUser'
      description 'Update user information'

      input_field :username, !types.String

      return_field :user, Types::UserType
      return_field :messages, types[Types::FieldErrorType]

      resolve(Utils::Auth.protect(lambda { |_obj, inputs, ctx|
        user = ctx[:current_user]
        if user.update(inputs.to_h.symbolize_keys)
          { user: user }
        else
          { messages: user.fields_errors }
        end
      }))
    end

    ChangePassword = GraphQL::Relay::Mutation.define do
      name 'changePassword'
      description 'Change user password'

      input_field :change_password, InputTypes::UserInputTypes::ChangePassword

      return_field :user, Types::UserType
      return_field :messages, types[Types::FieldErrorType]

      resolve(Utils::Auth.protect(lambda { |_obj, inputs, ctx|
        current_user = ctx[:current_user]
        params_with_password = inputs[:change_password].to_h.symbolize_keys
        if current_user.update_with_password(params_with_password)
          { user: current_user }
        else
          { messages: current_user.fields_errors }
        end
      }))
    end

    Destroy = GraphQL::Relay::Mutation.define do
      name 'destroyAccount'
      description 'Destroy user account'

      return_type types.Boolean

      resolve(Utils::Auth.protect(lambda { |_obj, _inputs, ctx|
        ctx[:current_user].destroy
        true
      }))
    end
  end
end
