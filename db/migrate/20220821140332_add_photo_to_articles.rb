class AddPhotoToArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :photo
    end   
  end
end
