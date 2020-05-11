class Client < ApplicationRecord
  belongs_to :enterprise
  enum regimen: { common: 'Comun', simplified: 'Simplificado' }

end
