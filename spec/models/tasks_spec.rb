# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Task, type: :model do
  # validasi
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(255) }
  end

  # default value
  describe 'default value' do
    it 'sets completed to false by default' do
      task = Task.create(title: 'Test task')
      expect(task.completed).to eq(false)
    end
  end

  # scope
  describe 'scopes' do
    let!(:pending_task)   { create(:task, :pending) }
    let!(:completed_task) { create(:task, :completed) }

    describe '.completed' do
      it 'returns only completed tasks' do
        expect(Task.completed).to include(completed_task)
        expect(Task.completed).not_to include(pending_task)
      end
    end

    describe '.pending' do
      it 'returns only pending tasks' do
        expect(Task.pending).to include(pending_task)
        expect(Task.pending).not_to include(completed_task)
      end
    end

    describe '.recent' do
      it 'returns tasks ordered by newest first' do
        expect(Task.recent.first).to eq(completed_task)
      end
    end

    describe '.search' do
      let!(:task) { create(:task, title: 'Learn Ruby') }

      it 'finds task by partial title' do
        expect(Task.search('Learn')).to include(task)
      end

      it 'is case insensitive' do
        expect(Task.search('learn')).to include(task)
      end

      it 'returns nothing for unmatched query' do
        expect(Task.search('xyz123')).to be_empty
      end
    end
  end
end