module Mutations
  module TagMutations
    Create = GraphQL::Relay::Mutation.define do
      name 'createTag'
      description 'Create a tag for the user'

      input_field :title, !types.String

      return_field :tag, Types::TagType

      resolve(Utils::Auth.protect(lambda { |_obj, inputs, ctx|
        user = ctx[:current_user]
        tag = user.tags.new(title: inputs[:id].strip)
        if tag.save
          { tag: tag }
        else
          { messages: tag.fields_errors }
        end
      }))
    end

    Edit = GraphQL::Relay::Mutation.define do
      name 'editTag'
      description 'Edit an existing tag for the user'

      input_field :id, !types.ID
      input_field :title, !types.String

      return_field :tag, Types::TagType

      resolve(Utils::Auth.protect(lambda { |_obj, inputs, ctx|
        user = ctx[:current_user]
        tag = user.tags.find(inputs[:id])
        tag.title = inputs[:title].strip
        if tag.save
          { tag: tag }
        else
          { messages: tag.fields_errors }
        end
      }))
    end

    Destroy = GraphQL::Relay::Mutation.define do
      name 'destroyTag'
      description 'Destroy a tag of the user'

      input_field :id, !types.ID

      return_type types.Boolean

      resolve(Utils::Auth.protect(lambda { |_obj, inputs, ctx|
        user = ctx[:current_user]
        tag = user.tags.find(inputs[:id])
        tag.destroy
        true
      }))
    end
  end
end
