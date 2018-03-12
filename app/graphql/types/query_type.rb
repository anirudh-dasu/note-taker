Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :notes do
    type types[Types::NoteType]
    description 'Fetch paginated notes collection'
    argument :offset, types.Int, default_value: 0
    argument :tags, types.String, default_value: nil
    argument :page, types.Int, default_value: 0
    argument :limit, types.Int, default_value: nil
    resolve lambda { |_note, args, _ctx|
      Note.tag_slug(args[:tag]).offset(args[:offset]).limit(args[:limit])
    }
  end
end
