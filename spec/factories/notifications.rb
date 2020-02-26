FactoryGirl.define do
  factory :notification do
    recipient_id 1
    actor_id 1
    read_at "2020-02-17 09:25:41"
    action "MyString"
    notifiable_id 1
    notifiable_type "MyString"
  end
end
