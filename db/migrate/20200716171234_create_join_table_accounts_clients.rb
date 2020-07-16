class CreateJoinTableAccountsClients < ActiveRecord::Migration[6.0]
  def change
    create_join_table :accounts, :clients do |t|
    end
  end
end
