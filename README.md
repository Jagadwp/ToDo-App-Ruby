# Todo App

A simple task management web app built with Padrino + Slim + PostgreSQL.

## Stack

| | |
|---|---|
| Framework | Padrino 0.16.1 |
| View | Slim |
| ORM | ActiveRecord |
| Database | PostgreSQL 15 |
| Ruby | 2.7.8 |

## Preview
<img width="681" height="794" alt="image" src="https://github.com/user-attachments/assets/1345feb9-8f45-4dff-88a4-77fc5905f677" />

## Features

- Create and delete tasks
- Toggle task completed / pending
- Filter tasks — All, Pending, Completed
- Sort tasks — Newest, Oldest, A-Z, Z-A
- Progress bar showing completion percentage
- Flash messages for action feedback
- Live reload in development

## Prerequisites

- Ruby 2.7.8
- PostgreSQL 15
- Bundler
- Google Chrome (for feature tests)

## Setup

**1. Clone and install dependencies:**
```bash
git clone <repo-url>
cd todo-app
bundle install --binstubs
```

**2. Setup database:**
```bash
bundle exec rake db:create
bundle exec rake db:migrate
```

**3. Start server:**
```bash
padrino start
```

Open `http://localhost:3000`

## Development

Live reload uses `rack-livereload` + `guard-livereload`.

Run two terminals:

```bash
# terminal 1
padrino start

# terminal 2
bundle exec guard
```

Debugging uses `byebug` — insert `byebug` at any point you want to inspect, then run the server normally.

## Testing

This project uses RSpec with 95%+ code coverage, including unit tests, controller tests, and browser automation tests via Capybara + Selenium WebDriver.

### Test stack

| Gem | Purpose |
|---|---|
| `rspec` + `rspec-padrino` | test framework |
| `rack-test` | HTTP request simulation |
| `factory_bot` + `faker` | test data generation |
| `database_cleaner` | clean database between tests |
| `shoulda-matchers` | model validation matchers |
| `capybara` + `selenium-webdriver` | browser automation |
| `simplecov` | code coverage report |

### Setup test database

```bash
bundle exec rake db:create RACK_ENV=test
bundle exec rake db:migrate RACK_ENV=test
```

### Run all tests

```bash
bundle exec rspec
```

### Run by type

```bash
# unit tests — model validations, scopes, callbacks
bundle exec rspec spec/models/

# controller tests — HTTP routes, status codes, redirects
bundle exec rspec spec/controllers/

# feature tests — full browser automation via Selenium
bundle exec rspec spec/features/
```

### Run a single file

```bash
bundle exec rspec spec/models/task_spec.rb
bundle exec rspec spec/controllers/tasks_spec.rb
bundle exec rspec spec/features/tasks_spec.rb
```

### Run a single test by line number

```bash
bundle exec rspec spec/features/tasks_spec.rb:19
```

### View coverage report

After running tests, open the generated report:

```bash
open coverage/index.html
```

### Test structure

```
spec/
├── factories/
│   └── tasks.rb          # FactoryBot blueprints for test data
├── models/
│   └── task_spec.rb      # unit tests — validations, scopes, search
├── controllers/
│   └── tasks_spec.rb     # request tests — CRUD routes
├── features/
│   └── tasks_spec.rb     # browser tests — full user flow via Selenium
└── spec_helper.rb        # RSpec + Capybara + DatabaseCleaner config
```

## Project Structure

```
todo-app/
├── app/
│   ├── app.rb                    # main app configuration
│   ├── controllers/
│   │   └── tasks.rb              # routing and CRUD logic
│   ├── helpers/
│   │   └── tasks_helper.rb       # view helper methods
│   └── views/
│       ├── layouts/
│       │   └── application.slim  # main layout
│       └── tasks/
│           ├── index.slim        # task list page
│           └── new.slim          # add task form
├── config/
│   ├── boot.rb                   # load dependencies
│   └── database.rb               # database configuration
├── db/
│   └── migrate/
│       └── 001_create_tasks.rb   # tasks table migration
├── models/
│   └── task.rb                   # Task model
├── spec/                         # test suite
├── Gemfile
└── Guardfile
```

## Database Schema

```
tasks
├── id          bigserial   primary key
├── title       varchar     task title
├── completed   boolean     completion status (default: false)
├── created_at  timestamp
└── updated_at  timestamp
```

## Routes

| Method | URL | Description |
|---|---|---|
| GET | `/tasks` | list all tasks |
| GET | `/tasks/new` | add task form |
| POST | `/tasks/create` | save new task |
| PATCH | `/tasks/update/:id` | toggle completed |
| DELETE | `/tasks/destroy/:id` | delete task |
