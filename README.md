##Test-driven development

* In 1st console start zeus: `zeus start`
* In 2nd start guard: `bundle exec guard`

## doing once

# Configure databse

Make existed role a superuser
> ALTER USER contest4good WITH SUPERUSER;

Change password
> ALTER USER contest4good WITH password 'contest4good';

Grant user to create db
> alter user contest4good CREATEDB;

Check user and properties
> select * from pg_user;

go out from console
> \q

# Devise

> devise init

> rails g devise Teacher

> rails g devise Student

> guard init

For Mac OS: install qt
> brew install qt

Support devise invitable generator
> rails generate devise_invitable:install

> rails generate devise_invitable Teacher

== prepare local project

* > bundle

* copy file config/database.example.yml as config/database.yml

* open pg console and execute these commands

> create role contest4good with createdb login password 'contest4good';

