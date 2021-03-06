# encoding: utf-8
FactoryGirl.define do
  factory :post, class: BlabbrCore::Persistence::Post do
    body  'My brand new post'
    topic  { Factory :topic }
    author { topic.author }
  end
end
