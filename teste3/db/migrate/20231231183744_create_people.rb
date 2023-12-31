class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :cpf
      t.string :state
      t.string :value

      t.timestamps
    end
  end
end
