
NotetakerSchema = GraphQL::Schema.define do
  mutation Types::MutationType
  query Types::QueryType

  instrument :query, Utils::ConcurrentBatchSetup
  lazy_resolve GraphQL::Batch::Promise, :sync
end
