Paperclip.interpolates :s3_safe_filename do |attachment, style|
  attachment.instance.normalized_file_name
end