Types::TagType = GraphQL::ObjectType.define do
  name "Tag"
  description "Tags created by users for notes"
  field :id, !types.ID
  field :title, types.String
  field :slug, types.String
  field :created_at, types.String
  field :updated_at, types.String

  field :notes do
    type types[Types::NoteType]
    description "All notes association with this tag."
    resolve ->(tag, args, ctx){
      tag.notes
    }
  end

  field :users do
    type types[Types::UserType]
    description "All users who use this tag."
    resolve ->(tag, args, ctx){
      tag.users
    }

  end

end
