Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :signUp, field: Mutations::UserMutations::SignUp.field
  field :updateUser, field: Mutations::UserMutations::Update.field
  field :changePassword, field: Mutations::UserMutations::ChangePassword.field
  field :deleteAccount, field: Mutations::UserMutations::Destroy.field

  field :createNote, field: Mutations::NoteMutations::Create.field
  field :editNote, field: Mutations::NoteMutations::Edit.field
  field :destroyNote, field: Mutations::NoteMutations::Destroy.field
  field :removeTag, field: Mutations::NoteMutations::RemoveTag.field

  field :createTag, field: Mutations::TagMutations::Create.field
  field :editTag, field: Mutations::TagMutations::Edit.field
  field :destroyTag, field: Mutations::TagMutations::Destroy.field

  field :signIn, field: Mutations::AuthMutations::SignIn.field
  field :signOut, field: Mutations::AuthMutations::SignOut.field
end
