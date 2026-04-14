# frozen_string_literal: true

class Task < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 1, maximum: 255 }

  before_create :set_default_completed

  scope :completed, -> { where(completed: true) }
  scope :pending,   -> { where(completed: false) }
  scope :recent,    -> { order(created_at: :desc) }

  private

  def set_default_completed
    self.completed = false if completed.nil?
  end
end