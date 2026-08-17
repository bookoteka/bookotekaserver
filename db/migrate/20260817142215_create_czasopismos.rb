class CreateCzasopismos < ActiveRecord::Migration[8.1]
  def change
    create_table :czasopismos do |t|
      t.string :tytul
      t.string :numer_wydania
      t.integer :strony
      t.date :przeczytano_w

      t.timestamps
    end
  end
end
