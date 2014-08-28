---
title: The D in CRUD
date: 2014-08-28 16:13 UTC
tags: ruby rails crud
---
From the [first post](http://www.gerardcote.com/2014/05/22/want-a-little-crud.html) in this series, you learned about setting up a simple Rails app and attacking the *Create* element of __CRUD__ (**C**reate, **R**ead, **U**pdate and **D**elete a database record). Subsequent posts dealt with the **R**ead and **U**pdate actions. This post goes through the *Delete* action.

Below I've written tests based on the *Story* for the *Delete* action in CRUD. The  associated code will make the tests pass. You can use this guide as a reference when practicing/implementing CRUD.

---

###The Story
**Given** I am on the homepage, **When** I click a link that is an Item’s name, **And** I see the Show Item page, **And** I click “Delete Item”, **Then** Then I do not see the Item name on the homepage

---

###Write Your Test
*(spec/features/item_spec.rb)*

    require 'spec_helper'

    feature 'index page without deleted item' do
      scenario 'user can delete an item' do
        visit '/'
        click_on 'Create Item'
        fill_in 'Item Name', with: "My Item"
        click_on 'Create Item'
        expect(page).to have_content("My Item")
        click_on 'My Item'
        click_on 'Delete Item'

        expect(page).to_not have_content("My Item")
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
    <%= link_to "Delete Item", item_path, method: "delete" %>

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

      def destroy
        @item = Item.find(params[:id])
        @item.destroy
        redirect_to root_path
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
    delete '/items/:id', to: 'items#destroy'

*Note that the code to generate routes for this app is done one action at a time to help with learning.*

---
###Screen Shots

![delete1](http://www.mjcomm.net/downloads/gschool/blog/item_crud_index.jpg)
![delete2](http://www.mjcomm.net/downloads/gschool/blog/item_crud_show_delete.jpg)
![delete3](http://www.mjcomm.net/downloads/gschool/blog/item_crud_deleted_index.jpg)

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


*[Gerard Cote](mailto:grcote@gmail.com) is a recovering MBA learning to code. He lives in Boulder, CO.*


