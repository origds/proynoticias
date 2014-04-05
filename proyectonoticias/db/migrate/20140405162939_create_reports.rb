class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :title
      t.text :content
      t.string :source
      t.integer :user_id
      t.string :author
      t.boolean :viewed
      t.boolean :approved
      t.boolean :sent
      t.boolean :published

      t.timestamps
    end
  end
end


       