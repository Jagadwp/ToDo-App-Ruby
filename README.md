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
<img width="713" height="830" alt="image" src="https://github.com/user-attachments/assets/8ab76942-aef3-4a6a-9305-888f31b59b64" />


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
