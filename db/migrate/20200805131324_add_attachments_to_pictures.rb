class AddAttachmentsToPictures < ActiveRecord::Migration[6.0]
  def change
    add_column :pictures, :attachments, :json
  end
end
