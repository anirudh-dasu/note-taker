Types::NoteType = GraphQL::ObjectType.define do
  name 'Note'
  description 'A note with tags and an author '
  field :id, !types.ID
  field :title, types.String
  field :content, types.String
  field :url, types.String
  field :kind, types.String
  field :slug, types.String
  field :created_at, types.String
  field :updated_at, types.String

  field :author, Types::UserType, 'Author of this note' do
    resolve lambda { |note, _args, _ctx|
      note.user
    }
  end

  field :tags, types[Types::TagType], 'All tags association with this note' do
    resolve lambda { |note, _args, _ctx|
      note.tags
    }
  end
end
