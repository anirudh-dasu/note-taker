Types::UserDeviceType = GraphQL::ObjectType.define do
  name "UserDevice"
  description "Each device belonging to a user"
  field :id, !types.ID
  field :provider, types.String
  field :uid, types.String
  field :device_type, types.String
  field :device_id, types.String
  field :jwt, types.String
  field :created_at, types.String
  field :updated_at, types.String

  field :user, Types::UserType, "Owner of this device" do
    resolve ->(user_device, args, ctx) {
      Utils::RecordLoader.for(User).load(user_device.user_id)
    }
  end
end
