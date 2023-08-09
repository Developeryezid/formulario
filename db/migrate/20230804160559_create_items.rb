class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :identification
      t.string :name
      t.string :email
      t.string :mobile

      t.timestamps
    end
  end
end
