class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :text
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :conversation
      t.integer :talent_id

      t.timestamps
    end
  end
end
