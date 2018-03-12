module Utils
  module ConcurrentBatchSetup
    module_function

    def before_query(_query)
      # Use the same executor for batch queries
      GraphQL::Batch::Executor.current ||= GraphQL::Batch::Executor.new
    end

    def after_query(_query)
      GraphQL::Batch::Executor.current = nil
    end
  end
end
