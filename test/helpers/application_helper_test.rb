# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal full_title, 'Endi\'s Microblog'
    assert_equal full_title('Help'), 'Help | Endi\'s Microblog'
  end
end
