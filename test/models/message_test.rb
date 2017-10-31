# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  def setup
    @user = users(:god)
    @message = @user.messages.build(content: "Dear God, how's it going?!")
  end

  # Validation Tests #########################################################
  test "should be valid" do
    assert @message.valid?
  end

  # Can't have a message without a user whose page it's on.
  test "user id should be present" do
    @message.user_id = nil
    refute @message.valid?
  end

  # Can't have a message without content.
  test "content should be present" do
    @message.content = " "
    refute @message.valid?
  end

  # Can't be over 800 words long.
  test "content shouldn't be over 5200 characters" do
    @message.content = "x" * 5201
    refute @message.valid?
  end

  test "message should be ordered most recent first" do
    assert_equal Message.first, messages(:most_recent)
  end

end
