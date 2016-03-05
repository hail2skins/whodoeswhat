class AttachmentsController < ApplicationController
  
  def show
    attachment = Attachment.find(params[:id])
    authorize attachment
    send_file attachment.file.path, disposition: :inline
  end
  
  
end
