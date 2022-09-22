class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
    
      t.string :title,  null: false, default: Setting.systems.default_str
    
      t.text :content
    
      t.string :ip,  null: false, default: Setting.systems.default_str

    

    

    

    
      t.timestamps null: false
    end
  end
end
