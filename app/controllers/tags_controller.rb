class TagsController < ApplicationController
  def index
    @tags = Tag.all

    respond_to do |format|
      format.html
      format.json { render json: @tags.tokens(params[:q]) }
    end
  end  
  
  def show
    @tag = Tag.find_by(name: params[:id])
  end
  
  
end
