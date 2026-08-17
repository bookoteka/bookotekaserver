class CreateKsiazkaGatuneks < ActiveRecord::Migration[8.1]
  def change
    create_table :ksiazka_gatuneks do |t|
      t.references :ksiazka, null: false, foreign_key: true
      t.references :gatunek, null: false, foreign_key: true

      t.timestamps
    end
  end
end
