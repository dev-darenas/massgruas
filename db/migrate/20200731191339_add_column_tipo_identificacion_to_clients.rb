class AddColumnTipoIdentificacionToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :tipo_identificacion, :string
  end
end
