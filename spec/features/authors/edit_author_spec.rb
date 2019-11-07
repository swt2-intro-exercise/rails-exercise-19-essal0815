require 'rails_helper'

describe "Author edit page", type: :feature do
    before do
        @author = FactoryBot.create :author
    end

    it "should render withour error" do
        visit edit_author_path@author
    end

    it "should have text inputs for an author's first name, last name, and homepage" do
        visit edit_author_path@author
        
        # these are the standard names given to inputs by the form builder
        expect(page).to have_field('author[first_name]')
        expect(page).to have_field('author[last_name]')
        expect(page).to have_field('author[homepage]')
    end

    it "should submit the form successful and update the author in the database" do
        visit edit_author_path@author
        page.fill_in 'author[last_name]', with: 'Test'
        find('input[type="submit"]').click
        @author.reload
        expect(@author.last_name).to(eq("Test"))
      end
end