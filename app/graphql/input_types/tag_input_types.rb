module InputTypes
  module TagInputTypes
    Create = GraphQL::InputObjectType.define do
      name 'tagInputType'
      description 'Input for creating tag'
      input_field :title,    !types.String
    end
  end
end
