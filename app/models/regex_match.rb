class RegexMatch < SimpleDelegator
  def self.from(match_or_nil, lineno = nil)
    return unless match_or_nil.present?
    new(match_or_nil, lineno)
  end

  def initialize(match_data, lineno)
    super(match_data)
    @lineno = lineno
  end

  # lazy-calc lineno if we don't have it
  def lineno
    return @lineno if @lineno
    count = pre_match.lines.count
    count += 1 if pre_match.end_with?("\n")
    @lineno = count
  end

  def all_captures
    names_by_index = {}
    regexp.named_captures.each do |name, indexes|
      indexes.each { |i| names_by_index[i] = name }
    end
    [[0, self[0]]].tap do |combined|
      if names_by_index.any?
        names_by_index.each { |index, name| combined << [name, self[index]] }
      else
        captures.each_with_index { |capture, index| combined << [index + 1, capture] }
      end
    end
  end

  def before_inline(max_length = 100)
    return "" if pre_match.blank?

    truncate_before(pre_match.lines.last, max_length)
  end

  def before_lines(max_lines: 10, max_length: 1024)
    used = 0
    [].tap do |shown|
      pre_match.lines.last(max_lines).reverse.each do |line|
        shown.prepend(truncate_before(line, max_length - used))
        used += line.length
        break if used >= max_length
      end
    end
  end

  def after_inline(max_length = 100)
    return "" if post_match.blank?

    truncate_after(post_match.lines.first, max_length)
  end

  def after_lines(max_lines: 10, max_length: 1024)
    used = 0
    [].tap do |shown|
      post_match.lines.first(max_lines).each do |line|
        shown << truncate_after(line, max_length - used)
        used += line.length
        break if used >= max_length
      end
    end
  end

  def truncate_before(str, max_length)
    # turn string around, truncate it, then put it back the right direction
    # so we end up with the front of the string lobbed/trailing off
    # ie: 'This is a long string' becomes '...long string'
    str.reverse.truncate(max_length).reverse
  end

  # just a placeholder in case we inline the truncation algo
  def truncate_after(str, max_length)
    str.truncate(max_length)
  end
end
