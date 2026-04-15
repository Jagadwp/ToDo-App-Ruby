# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Tasks', type: :feature, driver: :selenium_chrome do
  describe 'index page' do
    it 'shows the page title' do
      visit '/tasks'
      expect(page).to have_content('Todo App')
    end

    it 'shows empty message when no tasks' do
      visit '/tasks'
      expect(page).to have_content('No tasks yet')
    end
  end

  describe 'add task' do
    it 'can add a new task' do
      visit '/tasks'
      click_link 'Add Task'

      fill_in 'title', with: 'Learn Selenium'
      click_button 'Save'

      expect(page).to have_content('Learn Selenium')
      expect(page).to have_content('Task successfully added!')
    end

    it 'shows error when title is empty' do
      visit '/tasks/new'
      click_button 'Save'
      expect(page).to have_content("Title can't be blank")
    end
  end

  describe 'filter tasks' do
    before do
      create(:task, :pending,   title: 'Pending task')
      create(:task, :completed, title: 'Completed task')
    end

    it 'filters pending tasks' do
      visit '/tasks'
      click_link 'Pending'
      expect(page).to have_content('Pending task')
      expect(page).not_to have_content('Completed task')
    end

    it 'filters completed tasks' do
      visit '/tasks'
      click_link 'Completed'
      expect(page).to have_content('Completed task')
      expect(page).not_to have_content('Pending task')
    end
  end

  describe 'search tasks' do
    before { create(:task, title: 'Learn Ruby') }

    it 'finds task by title' do
      visit '/tasks'
      fill_in 'query', with: 'Learn'
      click_button 'Search'
      expect(page).to have_content('Learn Ruby')
    end
  end

  describe 'delete task' do
    before { create(:task, title: 'Task to delete') }

    it 'can delete a task' do
      visit '/tasks'
      expect(page).to have_content('Task to delete')
      click_button 'Delete'
      expect(page).not_to have_content('Task to delete')
    end
  end
end
