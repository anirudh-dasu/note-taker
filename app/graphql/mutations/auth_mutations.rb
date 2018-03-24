module Mutations
  module AuthMutations
    SignIn = GraphQL::Relay::Mutation.define do
      name 'signIn'
      description 'Sign in a user'

      input_field :sign_in, InputTypes::UserInputTypes::SignIn

      return_field :user, Types::UserType
      return_field :userDevice, Types::UserDeviceType
      return_field :messages, types[Types::FieldErrorType]

      resolve lambda { |_obj, inputs, _ctx|
        inputs = inputs[:sign_in]
        user = User.find_by(email: inputs[:email])
        if user && user.authenticate(inputs[:password])
          user_device = user.user_devices.find_or_create_by(inputs.to_h.symbolize_keys
                        .slice(:uid, :provider, :device_id, :device_type))
          user_device.generate_jwt_token!
          { user: user, userDevice: user_device }
        elsif user.nil?
          FieldError.error('user', 'Email not present. Please sign up first')
        else
          { messages: user.fields_errors }
        end
      }
    end

    SignOut = GraphQL::Relay::Mutation.define do
      name 'signOut'
      description 'Sign out a user'

      return_type types.Boolean

      resolve(Utils::Auth.protect(lambda { |_obj, _inputs, ctx|
        user_device = ctx[:current_device]
        blacklisted_tokens = Marshall.load(Rails.cache.read('blacklisted_tokens'))
        blacklisted_tokens << user_device.jwt
        Rails.cache.write('blacklisted_tokens', Marshall.dump(blacklisted_tokens))
        true
      }))
    end
  end
end
