Types::TagType = GraphQL::ObjectType.define do
  name 'Tag'
  description 'Tags created by users for notes'
  field :id, !types.ID
  field :title, types.String
  field :slug, types.String
  field :createdAt, types.String
  field :updatedAt, types.String

  field :notes do
    type types[Types::NoteType]
    description 'All notes association with this tag.'
    resolve lambda { |tag, _args, _ctx|
      tag.notes
    }
  end

  field :users do
    type types[Types::UserType]
    description 'All users who use this tag.'
    resolve lambda { |tag, _args, _ctx|
      tag.users
    }
  end
end
