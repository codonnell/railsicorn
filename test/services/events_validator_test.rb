require 'test_helper'

class EventsValidatorTest < ActiveSupport::TestCase
  def generic_events
    { events:
      { :"1" =>
        {
        timestamp: 1001,
        event: "<a href=http://www.torn.com/profiles.php?XID=827326>MrTseng</a> busted you out of jail.",
        seen: 1
        },
      :"2" =>
        {
        timestamp: 1051,
        event: "<a href=http://www.torn.com/profiles.php?XID=1946152>sullengenie</a> and <a href=http://www.torn.com/profiles.php?XID=2011902>CrimsonXray</a> attacked and hospitalized <a href=http://www.torn.com/profiles.php?XID=705054>Shinigy</a> [<a href = \"http://www.torn.com/loader.php?sid=attackLog&ID=9ba882e47de969353217594fbf95c926\">view</a>]",
        seen: 0
        } } }
  end

  test 'valid events are valid' do
    validator = EventsValidator.new(generic_events)
    assert validator.valid?
  end

  test 'timestamps are not negative' do
    events = generic_events.clone
    events[:events][:"1"][:timestamp] = -1234
    validator = EventsValidator.new(events)
    assert validator.invalid?
  end

  test 'seen should be 0 or 1' do
    events = generic_events.clone
    events[:events][:"1"][:seen] = 3
    validator = EventsValidator.new(events)
    assert validator.invalid?
  end
end
