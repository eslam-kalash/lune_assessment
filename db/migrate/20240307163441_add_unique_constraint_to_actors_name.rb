class AddUniqueConstraintToActorsName < ActiveRecord::Migration[7.1]
  def change
    add_index :actors, :name, unique: true
  end
end
