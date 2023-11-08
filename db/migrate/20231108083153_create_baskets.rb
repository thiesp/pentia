class CreateBaskets < ActiveRecord::Migration[7.1]
  def change
    create_table :baskets do |t|
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
