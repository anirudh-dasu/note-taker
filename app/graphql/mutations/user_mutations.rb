module Mutations
  module UserMutations
    SignUp = GraphQL::Relay::Mutation.define do
      name 'signUp'
      description 'Sign up'

      input_field :username, types.String
      input_field :email, types.String
      input_field :password, types.String
      input_field :password_confirmation, types.String
      input_field :provider, types.String
      input_field :uid, types.String
      input_field :device_type, types.String
      input_field :device_id, types.String

      return_field :user, Types::UserType
      return_field :messages, types[Types::FieldErrorType]

      resolve lambda { |_obj, inputs, _ctx|
        user = User.new(inputs.to_h.symbolize_keys.slice(:username, :email, :password,
                                                         :password_confirmation))
        user_device = UserDevice.new(inputs.to_h.symbolize_keys.slice(:device_id, :device_type,
                                                                      :provider, :uid))
        if user.save && user_device.save
          user_device.update(user: user)
          user_device.generate_jwt_token!
          { user: user }
        else
          { messages: user.fields_errors + user_device.fields_errors }
        end
      }
    end
  end
end
