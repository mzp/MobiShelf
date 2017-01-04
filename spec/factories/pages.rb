# frozen_string_literal: true
FactoryGirl.define do
  factory :page do
    sequence :no { |n| n }
    content { Rails.root.join('spec/fixtures/files/image.png').open }
  end
end
