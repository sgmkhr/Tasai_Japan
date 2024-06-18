class CreateInquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :inquiries do |t|
      t.string :name,         null: false
      t.string :email,        null: false
      t.string :phone_number, null: false
      t.integer :subject,     null: false, default: 0
      t.text :body,           null: false

      t.timestamps
    end
  end
end
