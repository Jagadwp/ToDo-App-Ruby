# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title     { Faker::Lorem.sentence(word_count: 3) }
    completed { false }
  end

  trait :completed do
    completed { true }
  end

  trait :pending do
    completed { false }
  end
end