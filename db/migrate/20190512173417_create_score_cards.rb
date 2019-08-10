class CreateScoreCards < ActiveRecord::Migration[5.1]
  def change
    create_table :score_cards do |t|
      t.decimal :idea_rating
      t.text :idea
      t.decimal :design_rating
      t.text :design
      t.decimal :experience_rating
      t.text :experience
      t.decimal :usability_rating
      t.text :usability
      t.decimal :monetization_rating
      t.text :monetization
      t.text :suggestions
      t.datetime :submitted_at
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
