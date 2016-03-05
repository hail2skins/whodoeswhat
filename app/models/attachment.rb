class Attachment < ApplicationRecord
  belongs_to :article, optional: true

  mount_uploader :file, AttachmentUploader
end
