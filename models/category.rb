# frozen_string_literal: true

class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }

  has_many :tasks, dependent: :nullify

  scope :alphabetical, -> { order(name: :asc) }
  scope :recent, -> { order(created_at: :asc) }
end
