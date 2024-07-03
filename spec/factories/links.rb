# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    original_url { 'test.com' }
    code { nil }
  end
end
