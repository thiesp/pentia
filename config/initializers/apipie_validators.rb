class AmountValidator < Apipie::Validator::BaseValidator

  def validate(value)
    self.class.validate(value)
  end

  def self.build(param_description, argument, options, block)
    if argument == :amount
      self.new(param_description)
    end
  end

  def description
    "Must be a negative or positive number."
  end

  def expected_type
    'amount'
  end

  def self.validate(value)
    value.to_s =~ /\A(0|[-]?[1-9]\d*)\Z$/
  end
end