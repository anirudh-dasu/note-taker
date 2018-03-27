class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  alias_attribute :createdAt, :created_at
  alias_attribute :updatedAt, :updated_at

  def fields_errors
    field_errors = []
    errors.each do |attr, msg|
      field_errors.push(FieldError.new(attr.to_s, msg))
    end
    field_errors
  end
end
