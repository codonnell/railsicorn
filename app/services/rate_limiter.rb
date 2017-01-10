class RateLimiter

  def initialize(client)
    @client = client
  end

  def query_available?
    !@token_buckets.empty?
  end

  def await_query
    @token_buckets.pop
  end

  # private

  # From Ruby Cookbook (https://www.safaribooksonline.com/library/view/ruby-cookbook/0596523696/ch03s12.html)
  def every_n_seconds(n)
    loop do
      before = Time.now
      yield
      interval = n - (Time.now - before)
      sleep(interval) if interval > 0
    end
  end

  def continuously_fill_token_buckets(token_buckets)
    every_n_seconds(@seconds_between_queries) { add_token(token_buckets) }
  end

  def add_token(token_buckets)
    token_buckets.push(:token) if token_buckets.size < @max_query_burst
  end
end
