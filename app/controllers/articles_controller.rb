# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  name        :string
#  content     :text
#  business_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ArticlesController < ApplicationController
  before_action :get_business
  
  def index
  end
  
  def new
    @article = @business.articles.build
  end
  
  def create
    @article = @business.articles.build(article_params)
    
    respond_to do |format|
      if @article.save
        format.html { redirect_to business_articles_path(@business), notice: "Knowledge created." }
      else
        format.html { render action 'new' }
      end
    end
  end
  
  
  
  private
    def get_business
      @business = Business.find(params[:business_id])
    end
    
    def article_params
      params.require(:article).permit(:name, :content)
    end
end
