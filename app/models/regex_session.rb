class RegexSession < ApplicationRecord
  MODES = {
    insensitive:  'i',
    extended:     'x',
    multiline:    'm',
  }.freeze

  validates :pattern, :haystack, presence: true

  def match?
    matches.any?
  end

  def matches
    return [] unless valid?

    regex = Regexp.new(pattern, modes)
    if lines
      haystack.lines.filter_map { |line| regex.match(line) }
    else
      [].tap do |needles|
        str = haystack
        loop do
          match = regex.match(str)
          break unless match
          needles << match
          str = match.post_match
          break if str.empty?
        end
      end
    end
  end

  def modes
    String.new do |enabled|
      MODES.each do |name, flag|
        enabled << flag if send(name)
      end
    end
  end

  def current_match
    matches.first
  end
end
