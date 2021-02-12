# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lists', type: :system do
  let!(:list) { create(:list) }
  
  describe 'get top_path' do
    before { visit top_path }
    
    context 'responds successfully' do
      it 'succeeds' do
        expect(page).to have_content 'ここはTopページです'
      end
      
      it 'succeeds' do
        expect(current_path).to eq '/top'
      end
    end
  end
  
  describe  '#new' do
    before { visit todolists_new_path }
    
    context 'responds successfully' do
      it 'succeeds' do
        expect(current_path).to eq '/todolists/new'
      end
      
      it 'succeeds' do
        expect(page).to have_button 'Post'
      end
    end
    
    context 'succeeds post'do
      it 'redirects to show' do
        fill_in 'list[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'list[body]', with: Faker::Lorem.characters(number:20)
        click_on 'Post'
        expect(page).to have_current_path todolist_path(List.last)
      end
    end
  end
  
  describe '#index' do
    before { visit todolists_path }
    
    context 'responds successfully' do
      it 'succeeds' do
        expect(page).to have_content list.title
        expect(page).to have_link list.title
      end
    end
  end
  
  describe '#show' do
    before { visit todolist_path(list) }
    
    context 'responds successfully' do
      it 'succeeds' do
        expect(page).to have_link 'Delete'
      end
      
      it 'succeeds' do
        expect(page).to have_link 'Edit'
      end
    end
    
    context 'succeeds links' do
      it 'edit' do
        click_on 'Edit'
        expect(current_path).to eq edit_todolist_path(list)
        # edit_link = find_all('a')[0]
        # edit_link.click
        # expect(current_path).to eq('/todolists/' + list.id.to_s + '/edit')
      end
    end
    
    context 'delete list' do
      it 'succeeds delete' do
        expect{ list.destroy }.to change{ List.count }.by(-1)
      end
    end
  end
  
  describe '#edit' do
    before { visit edit_todolist_path(list) }
    
    context 'responds successfully' do
      it 'succeeds' do
        expect(page).to have_field 'list[title]', with: list.title
        expect(page).to have_field 'list[body]', with: list.body
      end
      
      it 'succeeds' do
        expect(page).to have_button '保存'
      end
    end
    
    context 'update list' do
      it 'redirects to show' do
        fill_in 'list[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'list[body]', with: Faker::Lorem.characters(number: 20)
        click_on '保存'
        expect(page).to have_current_path todolist_path(list)
      end
    end
  end
end