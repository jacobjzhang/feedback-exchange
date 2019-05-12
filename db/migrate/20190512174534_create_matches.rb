class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.integer :creator_first
      t.integer :creator_second
      t.integer :score_card_from_first
      t.integer :score_card_from_second
      t.boolean :will_exchange_info_first
      t.boolean :will_exchange_info_second

      t.timestamps
    end
  end
end
