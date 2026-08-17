class CreateKsiazkas < ActiveRecord::Migration[8.1]
  def change
    create_table :ksiazkas do |t|
      t.string :tytul
      t.string :autor
      t.string :nazwa_serii
      t.boolean :jednotomowka
      t.integer :strony
      t.string :ocena
      t.string :format_ksiazki
      t.date :przeczytano_w
      t.boolean :dnf

      t.timestamps
    end
  end
end
