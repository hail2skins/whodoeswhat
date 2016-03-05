class AttachmentsController < ApplicationController
  
  def show
    attachment = Attachment.find(params[:id])
    authorize attachment
    send_file attachment.file.path, disposition: :inline
  end
  
  def new
    @index = params[:index].to_i
    @article = Article.new
    @article.attachments.build
    render layout: false
  end
  
  
end
