require 'rails_helper'

describe "Show author index page", type: :feature do
    before do
        @author = FactoryBot.create :author
    end

    it "should render withour error" do
        visit author_index_path
    end

    it "should have a link to the create authors route" do
        visit author_index_path
        expect(page).to have_link 'New', href: new_author_path
    end

    it "should have a table head name" do
        visit author_index_path
        expect(page.find(:id,"authorsTable").first(:xpath,'./tr/th').text).to eq("Name")
    end

    it "should have a table head homepage" do
        visit author_index_path
        expect(page.find(:id,"authorsTable").all(:xpath,'./tr/th')[1].text).to eq("Homepage")
    end

    it "should link to author details" do
        visit author_index_path
        expect(find(:table_row, {"Name" => @author.name}, {})).to have_link(href: author_path(@author))
    end
end 