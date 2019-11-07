require 'rails_helper'

describe "Author deleting", type: :feature do
    before do
        @author = FactoryBot.create :author
    end

    it "should be possible by clicking the delete link" do
        visit authors_path
        @authorsBefore = Author.count
        page.driver.submit :delete, author_path(@author), {}
        expect(Author.exists?(@author.id)).to be false
        expect(@authorsBefore - Author.count).to be 1
    end
end