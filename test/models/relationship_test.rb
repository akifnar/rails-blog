require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(
      follower_id: users(:akif).id,
      followed_id: users(:yakup).id
    )
    #@follower = users(:akif)
    #@followed = users(:yakup)
    #@relationship = @follower.active_relationships.create!(followed_id: @followed.id)
  end

  test "should be valid" do
    assert @relationship.valid?
   end

   test "should require a follower_id" do
     @relationship.follower_id = nil
     assert @relationship.invalid?
   end

   test "should require a followed_id" do
     @relationship.followed_id = nil
     assert @relationship.invalid?
   end
end
