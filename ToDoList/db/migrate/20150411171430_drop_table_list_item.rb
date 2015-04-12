class DropTableListItem < ActiveRecord::Migration
  def change
    drop_table :list_items
  end
end
