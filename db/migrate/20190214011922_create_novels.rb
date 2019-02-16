class CreateNovels < ActiveRecord::Migration[5.0]
  def change
    create_table :novels do |t|
      t.string :title
      t.string :summary
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
