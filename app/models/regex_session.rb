class RegexSession < ApplicationRecord
  MODES = {
    insensitive:  'i',
    extended:     'x',
    multiline:    'm',
  }.freeze

  validates :pattern, :haystack, presence: true

  before_save :generate_slug

  attr_accessor :savemode

  def match?
    matches.any?
  end

  def execute
    save! if savemode == "save"
    self
  end

  def matches
    @matches ||= find_matches
  end

  def find_matches
    return [] unless valid?

    regex = Regexp.new(pattern, modes)
    if lines
      haystack.lines.each_with_index.filter_map do |line, i|
        RegexMatch.from(regex.match(line), i + 1)
      end
    else
      [].tap do |needles|
        str = haystack
        loop do
          match = RegexMatch.from(regex.match(str))
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

  def generate_slug(force: false)
    return slug if slug.present? && !force

    5.times do
      candidate = SecureRandom.base58(16)
      next if self.class.find_by(slug: candidate)
      self.slug = candidate
      return candidate
    end
    errors.add(:slug, "Unable to generate unused slug")
    slug
  end
end
