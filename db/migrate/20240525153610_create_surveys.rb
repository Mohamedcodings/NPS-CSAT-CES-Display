class CreateSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :surveys do |t|
      t.string :survey_type
      t.integer :score
      t.text :comment
      t.datetime :timestamp

      t.timestamps
    end
  end
end
