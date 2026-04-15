# frozen_string_literal: true

module TodoApp
  class App
    module TasksHelper
      def status_badge(task)
        if task.completed
          '<span class="badge badge-done">Done</span>'
        else
          '<span class="badge badge-pending">Pending</span>'
        end
      end

      def task_card_class(task)
        task.completed ? 'card completed' : 'card'
      end

      def checkbox_class(task)
        task.completed ? 'checkbox-btn done' : 'checkbox-btn'
      end

      def format_date(datetime)
        return '-' if datetime.nil?

        datetime.strftime('%d %b %Y, %H:%M')
      end

      def completion_percentage(tasks)
        return 0 if tasks.empty?

        done = tasks.count(&:completed)
        ((done.to_f / tasks.count) * 100).round
      end

      def progress_bar(percentage)
        <<~HTML
          <div class="progress-wrap">
            <div class="progress-bar" style="width: #{percentage}%"></div>
            <span class="progress-label">#{percentage}% complete</span>
          </div>
        HTML
      end

      def filter_btn_class(current_filter, filter_name)
        current_filter == filter_name ? 'btn btn-primary' : 'btn'
      end

      def sort_btn_class(current_sort, sort_name)
        current_sort == sort_name ? 'btn btn-primary' : 'btn'
      end
    end

    helpers TasksHelper
  end
end
