Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :testField, types.String do
    description "An example field added by the generator"
    resolve ->(obj, args, ctx) {
      "Hello World!"
    }
  end


  field :notes do
    type types[Types::NoteType]
    description 'Fetch paginated notes collection'
    argument :offset, types.Int, default_value: 0
    argument :keywords, types.String, default_value: nil
    argument :tag, types.String, default_value:nil
    resolve ->(object, args, ctx) {
     Note.all
    }
  end

end
