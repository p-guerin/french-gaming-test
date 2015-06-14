class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null => false
      t.string :email, :null => false
      t.string :password_digest, :null => false
      t.string :age
      t.string :city
      t.string :country
      t.string :image
      t.string :steam
      t.string :facebook
      t.string :twitter
      t.string :youtube

      t.timestamps null: false
    end
  end
end
