class CreateArticlesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :author
      t.belongs_to :topic, foreign_key: true

      t.timestamps
    end
  end
end
