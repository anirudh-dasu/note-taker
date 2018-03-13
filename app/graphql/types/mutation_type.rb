Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :signUp, field: Mutations::UserMutations::SignUp.field
end
