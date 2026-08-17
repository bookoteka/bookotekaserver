class CreateGatuneks < ActiveRecord::Migration[8.1]
  def change
    create_table :gatuneks do |t|
      t.string :nazwa

      t.timestamps
    end
  end
end
