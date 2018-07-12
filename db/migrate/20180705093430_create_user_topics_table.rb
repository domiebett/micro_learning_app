class CreateUserTopicsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :user_topics do |t|
      t.references :user, foreign_key: true
      t.references :topic, foreign_key: true

      t.timestamps
    end
  end
end
