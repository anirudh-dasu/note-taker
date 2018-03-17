Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root of this schema. See available queries.'

  field :notes do
    name 'notes'
    description 'Fetch paginated notes collection of the current user'
    type types[Types::NoteType]
    argument :offset, types.Int, default_value: 0
    argument :tag, types.String, default_value: ''
    argument :keyword, types.String, default_value: ''
    resolve(Utils::Auth.protect(lambda { |_obj, args, ctx|
                                  user = ctx[:current_user]
                                  user.notes.latest.tag_slug(args[:tag]).paginate(args[:offset])
                                }))
  end

  field :tags do
    name 'tags'
    description 'Fetch paginated tags collection of the current user'
    type types[Types::TagType]
    argument :offset, types.Int, default_value: 0
    argument :note_id, types.ID, default_value: nil
    resolve(Utils::Auth.protect(lambda { |_obj, args, ctx|
      user = ctx[:current_user]
      root = args.nil? ? user : user.notes.find(args[:note_id])
      root.tags.latest.paginate(args[:offset])
    }))
  end

  field :note do
    name 'note'
    description 'Fetch a note by ID'
    type Types::NoteType
    argument :id, !types.ID
    resolve(Utils::Auth.protect(lambda { |_obj, args, ctx|
      user = ctx[:current_user]
      user.notes.find(args[:id])
    }))
  end

  field :tag do
    name 'tag'
    description 'Fetch a tag by ID'
    type Types::TagType
    argument :id, !types.ID
    resolve(Utils::Auth.protect(lambda { |_obj, args, ctx|
      user = ctx[:current_user]
      user.tags.find(args[:id])
    }))
  end

  field :notesCount do
    name 'notesCount'
    description 'Fetch the number of posts of current user'
    type types.Int
    resolve(Utils::Auth.protect(lambda { |_obj, _args, ctx|
      user = ctx[:current_user]
      user.notes.count
    }))
  end

  field :user do
    name 'user'
    description 'Return the current user'
    type Types::UserType
    resolve(Utils::Auth.protect(lambda { |_obj, _args, ctx|
      ctx[:current_user]
    }))
  end
end
