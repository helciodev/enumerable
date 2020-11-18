# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

module Enumerable
    # my_each
  def my_each
    return to_enum(:each) unless block_given?

    size.times do |i|
      yield self[i]
    end
    self
  end

  # my_each_with_index
  def my_each_with_index
    return to_enum(:each) unless block_given?

    size.times do |i|
      yield self[i], i
    end
    self
  end

  # my_select
  def my_select
    return to_enum(:each) unless block_given?

    arr = []
    my_each { |el| arr.push(el) if yield el }
    arr
  end

  # my_all
  def my_all?(my_arg = nil)
    if block_given?
      my_each { |el| return false if yield(el) == false }
      true
    elsif my_arg.nil?
      my_each { |el| return false if el.nil? || el == false }
    elsif !my_arg.nil? && (my_arg.is_a? Class)
      my_each { |el| return false if el.class != my_arg }
    elsif !my_arg.nil? && my_arg.class == Regexp
      my_each { |el| return false unless my_arg.match(el) }
    else
      my_each { |el| return false if el != my_arg }
    end
    true
  end

  #my_any
  def my_any?(my_arg = nil)
    if block_given?
      my_each { |el| return true if yield(el) == true }
      false

    elsif my_arg.nil?
      my_each { |el| return false if el.nil? || el == false }
    elsif !arg.nil? && (arg.is_a? Class)
      my_each { |el| return false if el.class != my_arg }
    elsif !my_arg.nil? && arg.class == Regexp
      my_each { |el| return false unless my_arg.match(el) }
    else
      my_each { |el| return false if el != my_arg }
    end
  end

  #my_none
  def my_none?(my_arg = nil)
    my_each { |el| return false if el } if !block_given? && my_arg.nil?

    my_each { |el| return false if yield(el) } if block_given?

    if my_arg.is_a?(Class)
      my_each { |el| return false if el.is_a?(my_arg) }
    elsif my_arg.is_a?(Regexp)
      my_each { |el| return false if el.to_s.match(my_arg) }
    elsif !my_arg.nil?
      my_each { |el| return false if el == my_arg }
    end
    true
  end
end
