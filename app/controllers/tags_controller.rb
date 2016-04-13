class TagsController < ApplicationController
  def index
    @tags = Tag.all

    respond_to do |format|
      format.html
      format.json { render json: @tags.tokens(params[:q]) }
    end
  end  
  
  def show
    #session[:request_referrer] = request.referrer
    @tag = Tag.find_by(name: params[:id])
    @business = Business.find(params[:business_id])
    @articles = Article.joins(:tags).where(business_id: @business.id, tags: {name: @tag.name})
  end
  
  
end
