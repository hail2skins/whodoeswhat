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
  after_action :update_contact, only: [:create, :update]
  
  def index
    @articles = @business.articles.all
    authorize @business
  end
  
  def new
    @article = @business.articles.build
    authorize @business
    @article.attachments.build
    @article.contacts.build
  end
  
  def create
    authorize @business
    @article = @business.articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to business_article_path(@business, @article), notice: "Knowledge created." }
      else
        format.html { render 'new' }
      end
    end
  end
  
  def show
    authorize @business
  end
  
  def edit
    authorize @business

  end
  
  def update
    authorize @business
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
      params.fetch(:article, {}).permit(:id, 
                                      :name, 
                                      :content,
                                      :_destroy,
                                      :contact_tokens,
                                      contacts_attributes: [:first_name, :last_name, :email, :_destroy],
                                      attachments_attributes: [:file, :file_cache, :_destroy])
    end
    
    def update_contact
      if @article.contacts.any?
        @article.contacts.each do |update|
          update.update_attribute(:business_id, @article.business_id) unless update.business_id
        end
      end
      
    end
    
end
