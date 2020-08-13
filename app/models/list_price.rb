class ListPrice < ApplicationRecord
  acts_as_paranoid
  belongs_to :client
  belongs_to :service
  belongs_to :service_including_deleted, class_name: "Service",
             foreign_key: 'service_id', with_deleted: true

  validates :service_id, uniqueness: {scope: :client_id}
end
