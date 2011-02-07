Paperclip.interpolates :s3_safe_filename do |attachment, style|
  attachment.original_filename.delete("#")
end