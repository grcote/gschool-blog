---
title: The R in CRUD
date: 2014-06-13 20:49 UTC
tags: ruby rails crud
---
From the [first post](http://www.gerardcote.com/2014/05/22/want-a-little-crud.html) in this series, you learned about setting up a simple Rails app and attacking the *Create* element of __CRUD__ (**C**reate, **R**ead, **U**pdate and **D**elete a database record). This post goes through the *Read* element.

Below I've written tests based on the *Story* for the *Read* action in CRUD. The  associated code will make the tests pass. You can use this guide as a reference when practicing/implementing CRUD.

In subsequent posts, I'll do the same thing for the **UD** (**U**pdate & **D**elete) actions.

---

###The Story
**Given** I am on the homepage, **When** I click a link that is an Item's name, **Then** I see the Item’s name on the Show Item page

---

###Write Your Test
*(spec/features/item_spec.rb)*

    require_relative '../spec_helper‘

    feature 'read/show page' do
      scenario 'user can view an item page' do
        visit '/'
        click_on 'Create Item'
        fill_in 'Item Name', with: "My Item"
        click_on 'Create Item'
        click_on 'My Item'

        expect(page).to have_content("My Item")
      end
    end

---
###Views

####index
*(app/views/items/index.html.erb)*

    <%= link_to "Create Item", new_item_path %>

    <% @items.each do |item| %>
      <%= link_to item.item_name, item_path(item)%>
    <% end %>

####show
*(app/views/items/show.html.erb)*

    <%= @item.item_name %>

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

      def show
        @item = Item.find(params[:id])
      end
    end
---
###Routes
*(config/routes.rb)*

    root to: 'items#index'
    post '/items', to: ‘items#create'
    get '/items/:id', to: 'items#show', as: 'item'

*Note that the code to generate routes for this app is done one action at a time to help with learning.*

---
###Screen Shots

![create1](http://www.mjcomm.net/downloads/gschool/blog/item_crud_create.jpg)
![create2](http://www.mjcomm.net/downloads/gschool/blog/item_crud_create_form.jpg)
![create3](http://www.mjcomm.net/downloads/gschool/blog/item_crud_create_index2.jpg)
![show1](http://www.mjcomm.net/downloads/gschool/blog/item_crud_show.jpg)

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

