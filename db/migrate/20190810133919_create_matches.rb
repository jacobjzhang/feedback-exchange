class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.references :score_card, foreign_key: true

      t.timestamps
    end
  end
end
