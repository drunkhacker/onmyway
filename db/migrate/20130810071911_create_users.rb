class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :id => false, :primary_key => "facebook_id" do |t|
      t.string :facebook_id
      t.string :name
      t.timestamps
    end
  end
end
