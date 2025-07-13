class RegexCheatSheet < OptStruct.new
  class Entry < OptStruct.new(:example, :description); end

  def self.entries(**)
    new(**).entries
  end

  option :path
  option :name, default: "cheats"
  option :paths, default: -> { default_paths }

  def entries
    file = path || paths[name] || paths.first.last
    YAML.load_file(file).map do |entry|
      Entry.new(example: entry["example"], description: entry["description"])
    end
  end

  private

  def default_paths
    {
      cheats: Rails.root.join("db", "regex_cheat_sheet.yaml"),
      examples: Rails.root.join("db", "regex_examples.yaml")
    }.with_indifferent_access
  end
end
