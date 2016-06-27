class AddActorFullName < ActiveRecord::Migration
  def change
    add_column :actors, :full_name, :string
  end
end