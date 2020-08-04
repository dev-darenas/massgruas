class AddActiveToTechnicals < ActiveRecord::Migration[6.0]
  def change
    add_column :technicals, :active, :boolean, default: true
  end
end
