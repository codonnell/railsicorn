require 'dry-validation'

class EventsValidator < Validator
  def initialize(response)
    events_array = convert_to_array(response)
    @result = schema.call(events_array)
  end

  Schema = Dry::Validation.Schema do
    each do
      schema do
        required(:torn_id) { int? & gt?(0) }
        required(:timestamp) { int? & gt?(0) }
        required(:event) { str? }
        required(:seen) { eql?(0) | eql?(1) }
      end
    end
  end

  def schema
    Schema
  end

  private

  def convert_to_array(response)
    events = []
    response[:events].each do |torn_id, event|
      event[:torn_id] = torn_id.to_s.to_i
      events << event
    end
    events
  end
end
