FactoryGirl.define do
  factory :token do
    type ""
    creator_id 1
    body "MyText"
    post_id 1
    layer_id 1
  end
end
