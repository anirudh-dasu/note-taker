module Mutations
  module NoteMutations
    Create = GraphQL::Relay::Mutation.define do
      name 'createNote'
      description 'Create a note for the user'

      input_field :title, !types.String
      input_field :content, types.String
      input_field :kind, types.String
      input_field :tags, types[InputTypes::TagInputTypes::Create]

      return_field :note, Types::NoteType
      return_field :messages, types[Types::FieldErrorType]

      resolve(Utils::Auth.protect(lambda { |_obj, inputs, ctx|
        user = ctx[:current_user]
        new_note = user.notes.build(inputs.to_h.symbolize_keys.slice(:title, :content, :kind))
        new_note.user_id = user.id

        inputs[:tags].each do |tag|
          tag = user.tags.find_or_create_by(title: tag[:title].strip)
          tag.notes << new_note
        end

        if new_note.save
          { note: new_note }
        else
          { messages: new_note.fields_errors }
        end
      }))
    end

    Edit = GraphQL::Relay::Mutation.define do
      name 'editNote'
      description 'edit a note of the user'

      input_field :id, !types.ID
      input_field :content, types.String
      input_field :kind, types.String
      input_field :tags, types[InputTypes::TagInputTypes::Create]

      return_field :note, Types::NoteType
      return_field :messages, types[Types::FieldErrorType]

      resolve(Utils::Auth.protect(lambda { |_obj, inputs, ctx|
        user = ctx[:current_user]
        note = user.notes.find(inputs[:id])
        note.update(inputs.to_h.symbolize_keys.slice(:content, :kind))

        inputs[:tags].each do |tag|
          tag = user.tags.find_or_create_by(title: tag[:title].strip)
          tag.notes << note
        end

        if note.save
          { note: note }
        else
          { messages: note.fields_errors }
        end
      }))
    end

    Destroy = GraphQL::Relay::Mutation.define do
      name 'destroyNote'
      description 'Destroy a note of the user'

      input_field :id, !types.ID
      return_type types.Boolean

      resolve(Utils::Auth.protect(lambda { |_obj, inputs, ctx|
        user = ctx[:current_user]
        note = user.notes.find(inputs[:id])
        note.destroy
        true
      }))
    end

    RemoveTag = GraphQL::Relay::Mutation.define do
      name 'removeTag'
      description 'Remove tag from this note'

      input_field :id, !types.ID
      input_field :tag_id, !types.ID

      return_field :note, Types::NoteType
      return_field :messages, types[Types::FieldErrorType]

      resolve(Utils::Auth.protect(lambda { |_obj, inputs, ctx|
        user = ctx[:current_user]
        note = user.notes.find(inputs[:id])
        tag = user.tags.find(inputs[:tag_id])
        note.tags.delete(tag)
        { note: note }
      }))
    end
  end
end
