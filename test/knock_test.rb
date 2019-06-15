require 'test_helper'

class KnockTest < ActiveSupport::TestCase
  test 'setupp block yields self' do
    Knock.setup do |config|
      assert_equal Knock, config
    end
  end
end
