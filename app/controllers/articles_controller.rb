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
    authorize @business
    @article.attachments.build
    @article.contacts.build
  end
  
  def create
    authorize @business
    whitelisted_params = article_params

    if params[:article][:contacts_attributes]
      whitelisted_params.delete(:contacts_attributes)
    end

    @article = @business.articles.build(whitelisted_params)

    params[:article][:contacts_attributes].values.each do |contact|
      email = contact[:email].downcase unless !contact[:email]
      
      if Contact.find_by(email: email)
        existing_contact = Contact.find_by(email: email)
        @article.contacts << existing_contact
      else
        new_contact = Contact.create!(first_name: contact[:first_name], 
                                      last_name: contact[:last_name], 
                                      email: email)
        @article.contacts << new_contact
      end
    end      
    
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
                                      contacts_attributes: [:first_name, :last_name, :email],
                                      attachments_attributes: [:file, :file_cache])
    end
    
    def check_for_contacts
      if params[:article][:contacts_attributes]
        whitelisted_params.delete(:contacts_attributes)
      end
    end
end
