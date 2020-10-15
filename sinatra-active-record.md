# ActiveRecord in Sinatra

Most instructions were taken from this [article](https://gist.github.com/jtallant/fd66db19e078809dfe94401a0fc814d2).

Install `bundler` if you didn't do it before.

```bash
gem install bundler
```

Create an empty project and create a `Gemfile` with `bundler`.
Let's say we will create a movies web.

```bash
mkdir movies-web
cd movies-web
bundle init
```

Add these gems. We're going to use `sqlite3` for the DB.

```bash
bundle add sinatra-activerecord sqlite3 rake
```

Create an `app.rb` file.

```ruby
# app.rb
require 'sinatra'
require 'sinatra/activerecord'
```

Create a `Rakefile`.

```ruby
# Rakefile
require 'sinatra/activerecord/rake'
require './app'
```

Create a file `config/database.yml`

```yaml
development:
  adapter: sqlite3
  database: db/dev.sqlite3
  pool: 50
  write_timeout: 300
  read_timeout: 300
```

Create a migration to create a movies table.
This instruction will create a migration file in `db/migrate/`.

```bash
rake db:create_migration NAME=create_movies_table
```

Add code to the migration for creating columns.

```ruby
class CreateMoviesTable < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :director
      t.integer :rating
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
```

Run the migration.
This instruction will create a database file `db/dev.sqlite3`
and `db/schema.rb`.

```bash
rake db:migrate
```

Create a `Movie` model.

```ruby
# db/models.rb
class Movie < ActiveRecord::Base
end
```

Load the `Movie` model into your app.

```ruby
# at the bottom of app.rb
require './db/models'
```

Create a seeds file.

```ruby
# db/seeds.rb
movies = [
  {name: 'Memento', director: 'Nolan', rating: 10},
  {name: 'Pulp Fiction', director: 'Tarantino', rating: 9}
]

movies.each do |m|
  Movie.create(m)
end
```

Run the seeds.
This will create movies into the database `db/dev.sqlite3`.

```ruby
rake db:seed
```

Create `views/layout.erb` file.

```erb
<!DOCTYPE html>
<html>
<head>
    <title>My Movies</title>
</head>
<body>
<%= yield %>
</body>
</html>
```

Create `views/index.erb` file.

```erb
    <ul>
        <% @movies.each do |movie| %>
            <li><%= movie.name %></li>
        <% end %>
    </ul>
```

Create a route for the home page.

```ruby
# app.rb
get '/' do
  # https://guides.rubyonrails.org/active_record_basics.html
  @movies = Movie.all
  erb :index
end
```
