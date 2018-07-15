class CreateSentArticlesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :sent_articles do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :article, foreign_key: true

      t.timestamps
    end
  end
end
