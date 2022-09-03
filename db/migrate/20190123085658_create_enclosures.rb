class CreateEnclosures < ActiveRecord::Migration
  def change
    create_table :enclosures do |t|
      t.timestamps null: false

      t.string :file,  null: false, default: ""

      t.references :article
      t.references :carousel
      t.references :home_setting
    end
  end
end
