# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :original_url, null: false, index: true
      t.string :code, null: false

      t.timestamps
    end
  end
end
