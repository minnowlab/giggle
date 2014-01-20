# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification_relationship, :class => 'NotificationRelationships' do
    user nil
    notification nil
    read false
  end
end
