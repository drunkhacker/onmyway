class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :sender_id, :null => false
      t.string :receiver_id, :null => false
      t.integer :status, :default => 0
      t.string :facebook_id
      t.string :salt, :unique => true
      t.decimal :latitude, :precision => 64, :scale => 12
      t.decimal :longitude, :precision => 64, :scale => 12
      t.timestamps
    end
  end
end
