
NotetakerSchema = GraphQL::Schema.define do
  mutation Types::MutationType
  query Types::QueryType

  max_depth 9
  max_complexity 200

  instrument :query, Utils::ConcurrentBatchSetup
  # lazy_resolve GraphQL::Batch::Promise, :sync
end
