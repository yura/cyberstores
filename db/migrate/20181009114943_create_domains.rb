class CreateDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :domains do |t|
      t.references :store, index: true
      t.string :name, index: true, unique: true
      t.boolean :master, default: false

      t.timestamps
    end
  end
end
