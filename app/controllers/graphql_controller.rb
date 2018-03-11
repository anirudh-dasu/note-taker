class GraphqlController < ApplicationController


  def create
    if params[:query].present?
      # Execute one query
      query_string, variables, operation_name  = params[:query], params[:variables], params[:operationName]
      result = execute(query_string, variables,operation_name)
    else
      # Execute multi queries
      queries_params = params[:_json]
      result = multiplex(queries_params)
    end

    render json: result
  end

  private

  # Execute one query
  def execute(query, variables, operation_name)
    puts GraphQLFormatter.new(query) if Rails.env.development?
    query_variables = ensure_hash(variables)
    context = {
      # current_user:current_user,
      request: request
    }
    result = NotetakerSchema.execute(query, variables: query_variables, context:context, operation_name: operation_name)
    result
  end

    # Execute multi queries
  def multiplex(queries_params)
    if Rails.env.development?
      queries_params.each { |query| puts GraphQLFormatter.new(query[:query]) }
    end

    queries = queries_params.map do |query|
      {
        query: query[:query],
        variables: ensure_hash(query[:variables]),
        context: {
          # current_user: current_user,
          request: request
        },
        operation_name: query[:operationName]
      }
    end

    NotetakerSchema.multiplex(queries)
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
