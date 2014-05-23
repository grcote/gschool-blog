---
title: Need a little CRUD?
date: 2014-05-22 20:43 UTC
tags: ruby rails crud
---

Are you new to Rails? If so, you're probably getting knee-deep into __CRUD__ (**C**reate, **R**ead, **U**pdate and **D**elete a database record). It is one of the most important foundational elements of a Rails app. This post will walk you through the steps of getting a super simple Rails app setup and highlight the bare-bones steps of **CRUD**ding an *"Item"*.

Below I've written tests based on the *Story* for the *Create* action in CRUD. The  associated code will make the tests pass. You can use this guide as a reference when practicing/implementing CRUD.

In subsequent posts, I'll do the same thing for the **RUD** (**R**ead, **U**pdate & **D**elete) actions.

---
### Getting Started
We are going to create a very barebones Rails CRUD app. There is little to no HTML formatting, no page title information and the database has only one field (other than ID).

For the app we'll be using [RSpec for Rails](https://rubygems.org/gems/rspec-rails), [Postgres](https://rubygems.org/gems/pg), [Capybara](https://rubygems.org/gems/capybara) and [ActiveRecord](https://rubygems.org/gems/activerecord).


1. *Create the Rails App*
    - `$ rails new item_crud --database=postgresql --skip-test-unit`
    - the example uses a Postgres database
    - the example uses RSpec instead of Test-Unit
2. *Create the Databases (test and development)*
    - `$ rake db:create:all`
3. *Add the Gems listed to the Gemfile and bundle*
    - [RSpec for Rails](https://rubygems.org/gems/rspec-rails), [Postgres](https://rubygems.org/gems/pg), [Capybara](https://rubygems.org/gems/capybara) and [ActiveRecord](https://rubygems.org/gems/activerecord)
    - `$ bundle install`
4. *Setup Testing*
    - `$ rails generate rspec:install`
    - Add require *‘capybara/rspec'* to spec_helper
5. *Add an Items table to the database*
    - `$ rails generate migration CreateItems item_name:string`
    - Run the migrations
      - `$ rake db:migrate` and `$ rake db:migrate RAILS_ENV=test`
6. *Run your tests*
    - `$ rspec`
7. *Startup up your webserver in your app's directory*
    - `$ rails s'

---

###The Story
**Given** I am on the homepage, **When** I click “Create Item”, **And** a New Item page is shown, **And** I fill in the name of an Item, **And** I click “Create Item", **Then** I see the Item name on the homepage

---

###Write Your Test
*(spec/features/item_spec.rb)*

    require_relative '../spec_helper‘

    feature 'create and index page' do
      scenario 'user can create an item' do
        visit '/'
        click_on 'Create Item'
        fill_in 'Item Name', with: "My Item"
        click_on 'Create Item'

        expect(page).to have_content("My Item")
      end
    end
---
###Model
*(app/models/item.rb)*

    class Item < ActiveRecord::Base

    end
---
###Views

####index
*(app/views/items/index.html.erb)*

    <%= link_to "Create Item", new_item_path %>

    <% @items.each do |item| %>
      <%= item.item_name %>
    <% end %>

####new
*(app/views/items/new.html.erb)*

    <%= form_for @item do |f| %>
      <%= f.label :item_name, "Item Name" %>
      <%= f.text_field :item_name %>
      <%= f.submit "Create Item" %>
    <% end %>
---
###Controller
*(app/controllers/items_controller.rb)*

    class ItemsController < ApplicationController
      def index
        @items = Item.all
      end

      def new
        @item = Item.new
      end

      def create
        Item.create(item_name: params[:item][:item_name])
        redirect_to root_path
      end
    end
---
###Routes
*(config/routes.rb)*

    root to: 'items#index'
    get '/items/new', to: 'items#new',

*Note that he code to generate routes for this app is done one action at a time to help with learning.*

---
###Screen Shots

![create1](http://www.mjcomm.net/downloads/gschool/blog/item_crud_create.jpg)
![create2](http://www.mjcomm.net/downloads/gschool/blog/item_crud_create_form.jpg)
![create2](http://www.mjcomm.net/downloads/gschool/blog/item_crud_create_index.jpg)

---
###Other Resources


-  [Models & Active Record Basics](http://guides.rubyonrails.org/active_record_basics.html)
-  [Views, Layouts & Rendering](http://guides.rubyonrails.org/layouts_and_rendering.html)
-  [Controllers](http://guides.rubyonrails.org/action_controller_overview.html)
-  [Routing](http://guides.rubyonrails.org/routing.html )
-  [Migrations](http://guides.rubyonrails.org/migrations.html)
-  [Rails Command Line & Rake Tasks](http://guides.rubyonrails.org/command_line.html)
-  [Form Helpers](http://guides.rubyonrails.org/form_helpers.html)

---
####More to Come...

Check back in subsequent posts for more on CRUD.

---


*[Gerard Cote](mailto:grcote@gmail.com) is a recovering MBA learning to code. He lives in Boulder, CO.*

