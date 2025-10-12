class CreateRegexSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :regex_sessions do |t|
      t.string :slug, index: true
      t.text :pattern
      t.text :haystack
      t.boolean :lines

      # regex mode flags
      t.boolean :insensitive
      t.boolean :extended
      t.boolean :multiline

      t.timestamps
    end
  end
end
