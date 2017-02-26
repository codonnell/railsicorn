class ApiError < StandardError
  def self.from_hash(err_hash)
    CLASS_MAP[err_hash[:error][:code]].new
  end

  CLASS_MAP = {
    0 => ApiError,
    1 => EmptyKeyError,
    2 => IncorrectKeyError,
    3 => WrongTypeError,
    4 => WrongFieldsError,
    5 => RateLimitError,
    6 => InvalidIdError,
    7 => AccessDeniedError,
    8 => IpBlockError,
    9 => ApiDisabledError,
    10 => FederalJailError
    }
end
