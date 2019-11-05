class AuthorsController < ApplicationController
    def new
        @author = Author.new
    end

    def index
        @authors = Author.all
    end

    def show
        @author = Author.find(params[:id])
    end

    def create
        @author = Author.new(authors_params)
       
        if @author.save
            redirect_to @author
          else
            render 'new'
        end
        #redirect_to root_path, notice:"Success"
    end

    private
        def authors_params
            params.require(:author).permit(:first_name, :last_name, :homepage)
        end
end
