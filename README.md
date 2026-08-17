# Rails Transactions API

A RESTful API built with Ruby on Rails as a learning project.

The main goal of this project is to understand how Rails works from the ground up, especially its conventions, Active Record, migrations, routing, controllers, HTTP responses, and database relationships.

## Purpose

This project is being developed without relying on AI-generated code.

The idea is to learn Rails by building, breaking, researching, and understanding what happens behind the framework.

Throughout the project, I am also comparing Rails concepts with technologies I already know from the .NET ecosystem.

## Technologies

- Ruby
- Ruby on Rails
- PostgreSQL
- Active Record
- REST API
- HTTP / JSON

## Concepts Studied

### Rails fundamentals

- Rails API-only applications
- Rails CLI
- Generators
- Controllers
- Routes
- RESTful endpoints
- HTTP methods and status codes
- JSON responses
- Request parameters
- Strong Parameters

### Database

- PostgreSQL
- Active Record
- Migrations
- Schema management
- UUID primary keys
- Database relationships
- Foreign keys
- `created_at` and `updated_at`
- Rollbacks

### Active Record

- `all`
- `find`
- `find_by`
- `where`
- `new`
- `create`
- `save`
- `update`
- `destroy`
- `Model associations`

## 🏗️ Current Domain

The API currently contains the following entities:

```text
User
 ├── Address
 │
 └── Transactions

Relationships
User 1 ───── 1 Address
User 1 ───── N Transactions

```