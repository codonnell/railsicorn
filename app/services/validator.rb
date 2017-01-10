class Validator
  def initialize(response)
    @result = schema.call(response)
  end

  def schema
    raise NotImplementedError
  end

  def valid?
    @result.success?
  end

  def invalid?
    !valid?
  end

  def validated
    raise 'Response is invalid' if invalid?
    @result.to_h
  end

  def errors
    @result.hints(full: true)
  end
end
