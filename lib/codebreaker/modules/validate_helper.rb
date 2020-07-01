# frozen_string_literal: true

# validate helper
module ValidateHelper
  include Codebreaker::Validator

  def validate_field(field, field_type)
    case field_type
    when 'name' then validate_name?(field)
    when 'difficalty' then validate_difficalty?(field)
    when 'guess' then validate_guess?(field)
    end
  end
end
