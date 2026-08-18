class RemoveDnfFromKsiazkas < ActiveRecord::Migration[8.1]
  def change
    remove_column :ksiazkas, :dnf, :boolean
  end
end
