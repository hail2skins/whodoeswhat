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
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  def index
    @articles = @business.articles.all
    authorize @business
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
        format.html { render 'new' }
      end
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @article.update(article_params)
      flash[:notice] = "Article has been updated."
      redirect_to [@business, @article]
    else
      flash.now[:alert] = "Article has not been updated."
      render "edit"
    end
  end
  
  def destroy
    @article.destroy
    flash[:notice] = "Article has been deleted."
    redirect_to business_articles_path(@business)
  end  
    
  
  
  
  private
    def get_business
      @business = Business.find(params[:business_id])
    end
    
    def set_article
      @article = @business.articles.find(params[:id])
    end
    
    def article_params
      params.require(:article).permit(:name, :content)
    end
end
