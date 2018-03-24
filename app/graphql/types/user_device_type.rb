Types::UserDeviceType = GraphQL::ObjectType.define do
  name 'UserDevice'
  description 'Each device belonging to a user'
  field :id, !types.ID
  field :provider, types.String
  field :uid, types.String
  field :deviceType, types.String
  field :deviceId, types.String
  field :jwt, types.String
  field :createdAt, types.String
  field :updatedAt, types.String

  field :user, Types::UserType, 'Owner of this device' do
    resolve lambda { |user_device, _args, _ctx|
      Utils::RecordLoader.for(User).load(user_device.user_id)
    }
  end
end
