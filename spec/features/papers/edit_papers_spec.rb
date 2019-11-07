require 'rails_helper'

describe "edit paper page", type: :feature do
  before do
    @paper = FactoryBot.create :paper_without_author
    authors = FactoryBot.create_list(:author, 2)
    @author1 = authors[0]
    @author2 = authors[1]
    @author2.update(first_name:"Test")
  end


  it "allows to select all authors" do
    visit edit_paper_path(@paper)
    expect(page).to have_select("author_ids", with_options:[@author1.name, @author2.name])
  end

  it "allows to select multiple authors" do
    visit edit_paper_path(@paper)
    expect(page.find(:css,'select[multiple="multiple"]')).to_not be_nil
  end

  it "actually updates the authors" do
    visit edit_paper_path(@paper)
    expect(@paper.authors).not_to include(@author1, @author2)

    select @author1.name, :from => "author_ids"
    select @author2.name, :from => "author_ids"
    find('input[type="submit"]').click
    @paper.reload
    expect(@paper.authors).to include(@author1, @author2)
  end

  it "can remove selected authors" do
    visit edit_paper_path(@paper)
    for author in Author.all
      unselect author.name, :from => "author_ids"
    end
    find('input[type="submit"]').click
    @paper.reload
    expect(@paper.authors).to be_empty
  end

end 