require "test_helper"

class RacesHelperTest < ActionView::TestCase
  include ApplicationHelper

  test "format_signed_delta returns em dash for nil" do
    assert_equal "—", format_signed_delta(nil)
  end

  test "format_signed_delta returns zero string for zero" do
    assert_equal "0:00.0", format_signed_delta(0)
  end

  test "format_signed_delta returns positive prefix for positive ms" do
    assert_equal "+0:01.5", format_signed_delta(1500)
  end

  test "format_signed_delta returns negative prefix for negative ms" do
    assert_equal "-0:01.5", format_signed_delta(-1500)
  end

  test "format_signed_delta formats minutes and seconds" do
    assert_equal "+1:23.4", format_signed_delta(83_400)
  end
end
