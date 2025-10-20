class RegexSession < ApplicationRecord
  MODES = {
    insensitive:  'i',
    extended:     'x',
    multiline:    'm',
  }.freeze

  validates :pattern, :haystack, presence: true

  before_save :generate_slug

  attr_accessor :savemode, :result_index
  attr_writer :result_index

  def match?
    matches.any?
  end

  def execute
    case savemode
    when "save" then save!
    when "fork"
      return self.class.create!(attributes.except("id", "slug", "created_at"))
    end
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
  rescue RegexpError => e
    Rails.logger.warn "RegexpError: #{e.inspect}"
    []
  end

  def modes
    String.new.tap do |enabled|
      MODES.each do |name, flag|
        enabled << flag if send(name)
      end
    end
  end

  def result_index
    return 0 if !defined?(@result_index) || @result_index.blank?

    @result_index.to_i
  end

  def current_match
    return matches.first if result_index < 0
    return matches.last if result_index >= matches.count

    matches[result_index]
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

  def to_param
    slug
  end
end
