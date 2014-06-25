---
title: The U in CRUD
date: 2014-06-25 03:56 UTC
tags: ruby rails crud
---
From the [first post](http://www.gerardcote.com/2014/05/22/want-a-little-crud.html) in this series, you learned about setting up a simple Rails app and attacking the *Create* element of __CRUD__ (**C**reate, **R**ead, **U**pdate and **D**elete a database record). This post goes through the *Update* element.

Below I've written tests based on the *Story* for the *Update* action in CRUD. The  associated code will make the tests pass. You can use this guide as a reference when practicing/implementing CRUD.

In subsequent posts, I'll do the same thing for the **D** (**D**elete) action.

---

###The Story
**Given** I am on the homepage, **When** I click a link that is an Item’s name, **And** I see the Show Item page, **And** I click “Update Item”, **And** I fill in an updated name of an Item, **And** I click “Update Item”, **Then** I see the updated name on the Show Item page

---

###Write Your Test
*(spec/features/item_spec.rb)*

    require 'spec_helper'

    feature 'read/show page with updated item' do
      scenario 'user can update an item' do
        visit '/'
        click_on 'Create Item'
        fill_in 'Item Name', with: "My First Item"
        click_on 'Create Item'
        click_on 'My First Item'
        click_on 'Update Item'
        fill_in 'Item Name', with: "My Updated Item"
        click_on 'Update Item'

        expect(page).to have_content("My Updated Item")
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

    <%= link_to "Update Item", edit_item_path %>

####edit
*(app/views/items/edit.html.erb)*

    <%= form_for @item do |f| %>

      <%= f.label :item_name, "Item Name" %>
      <%= f.text_field :item_name %>

      <%= f.submit "Update Item" %>

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

      def show
        @item = Item.find(params[:id])
      end

      def edit
        @item = Item.find(params[:id])
      end

      def update
        @item = Item.find(params[:id])
        @item.update_attributes(item_name: params[:item][:item_name])
        redirect_to item_path(@item)
      end
    end

---
###Routes
*(config/routes.rb)*

    root to: 'items#index'
    get '/items/new', to: 'items#new', as: 'new_item'
    post '/items', to: ‘items#create'
    get '/items/:id', to: 'items#show', as: ‘item’
    get '/items/:id/edit', to: 'items#edit', as: 'edit_item'
    patch '/items/:id', to: 'items#update'
    put '/items/:id', to: 'items#update'

*Note that the code to generate routes for this app is done one action at a time to help with learning.*

---
###Screen Shots

![create1](http://www.mjcomm.net/downloads/gschool/blog/item_crud_create.jpg)
![create2](http://www.mjcomm.net/downloads/gschool/blog/item_crud_create_form.jpg)
![create3](http://www.mjcomm.net/downloads/gschool/blog/item_crud_create_index2.jpg)
![update1](http://www.mjcomm.net/downloads/gschool/blog/item_crud_show_update.jpg)
![update2](http://www.mjcomm.net/downloads/gschool/blog/item_crud_edit_form.jpg)
![update3](http://www.mjcomm.net/downloads/gschool/blog/item_crud_updated_show.jpg)

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

Check back in subsequent posts for more the last element of CRUD.

---


*[Gerard Cote](mailto:grcote@gmail.com) is a recovering MBA learning to code. He lives in Boulder, CO.*
