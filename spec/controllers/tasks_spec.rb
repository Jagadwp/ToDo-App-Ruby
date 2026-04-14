# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Tasks controller', type: :controller do
  describe 'GET /tasks' do
    it 'returns 200' do
      get '/tasks'
      expect(last_response.status).to eq(200)
    end

    it 'shows all tasks' do
      create(:task, title: 'Test task')
      get '/tasks'
      expect(last_response.body).to include('Test task')
    end

    context 'with filter' do
      let!(:pending_task)   { create(:task, :pending, title: 'Pending task') }
      let!(:completed_task) { create(:task, :completed, title: 'Completed task') }

      it 'filters pending tasks' do
        get '/tasks', filter: 'pending'
        expect(last_response.body).to include('Pending task')
        expect(last_response.body).not_to include('Completed task')
      end

      it 'filters completed tasks' do
        get '/tasks', filter: 'completed'
        expect(last_response.body).to include('Completed task')
        expect(last_response.body).not_to include('Pending task')
      end
    end

    context 'with search' do
      let!(:task) { create(:task, title: 'Belajar Ruby') }

      it 'returns matching tasks' do
        get '/tasks', query: 'Belajar'
        expect(last_response.body).to include('Belajar Ruby')
      end

      it 'returns empty for unmatched query' do
        get '/tasks', query: 'xyz123'
        expect(last_response.body).to include('No tasks found')
      end
    end
  end

  describe 'GET /tasks/new' do
    it 'returns 200' do
      get '/tasks/new'
      expect(last_response.status).to eq(200)
    end
  end

  describe 'POST /tasks/create' do
    context 'with valid params' do
      it 'creates a new task' do
        expect do
          post '/tasks/create', title: 'New task'
        end.to change(Task, :count).by(1)
      end

      it 'redirects to index' do
        post '/tasks/create', title: 'New task'
        expect(last_response.status).to eq(302)
        follow_redirect!
        expect(last_request.path).to eq('/tasks')
      end
    end

    context 'with invalid params' do
      it 'does not create task without title' do
        expect do
          post '/tasks/create', title: ''
        end.not_to change(Task, :count)
      end
    end
  end

  describe 'PATCH /tasks/update/:id' do
    let!(:task) { create(:task, :pending) }

    it 'toggles completed to true' do
      patch "/tasks/update/#{task.id}", {}, 'HTTP_X_HTTP_METHOD_OVERRIDE' => 'PATCH'
      expect(task.reload.completed).to eq(true)
    end

    it 'toggles completed back to false' do
      task.update(completed: true)
      patch "/tasks/update/#{task.id}", {}, 'HTTP_X_HTTP_METHOD_OVERRIDE' => 'PATCH'
      expect(task.reload.completed).to eq(false)
    end

    it 'redirects to index' do
      patch "/tasks/update/#{task.id}"
      expect(last_response.status).to eq(302)
    end
  end

  describe 'DELETE /tasks/destroy/:id' do
    let!(:task) { create(:task) }

    it 'deletes the task' do
      expect do
        delete "/tasks/destroy/#{task.id}"
      end.to change(Task, :count).by(-1)
    end

    it 'redirects to index' do
      delete "/tasks/destroy/#{task.id}"
      expect(last_response.status).to eq(302)
    end
  end
end
