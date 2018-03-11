Types::UserType = GraphQL::ObjectType.define do
  name "User"
  description "A user who can create notes and tags"
  field :id, !types.ID
  field :email, types.String
  field :created_at, types.String
  field :updated_at, types.String
  field :username, types.String

  field :notes do
    type types[Types::NoteType]
    description "All notes association with this user."
    resolve ->(user, args, ctx){
      user.notes
    }
  end

  field :tags do
    type types[Types::TagType]
    description "All tags association with this user."
    resolve ->(user, args, ctx){
      user.tags
    }
  end

  field :user_devices do
    type types[Types::UserDeviceType]
    description "All user_devices association with this user."
    resolve ->(user, args, ctx){
      user.user_devices
    }
  end
end
