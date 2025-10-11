class CreateRegexSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :regex_sessions do |t|
      t.string :slug, index: true
      t.text :pattern
      t.text :haystack
      t.boolean :lines
      t.string :flags, array: true

      t.timestamps
    end
  end
end
