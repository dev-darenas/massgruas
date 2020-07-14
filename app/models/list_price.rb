class ListPrice < ApplicationRecord
  belongs_to :client
  belongs_to :service
  validates :service_id, uniqueness: {scope: :client_id}
end
