# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

module Enumerable
  # my_each
  def my_each
    return to_enum(:each) unless block_given?

    arr = *self
    size.times do |i|
      yield arr[i]
    end
    self
  end

  # my_each_with_index
  def my_each_with_index
    return to_enum(:each) unless block_given?

    arr = *self
    size.times do |i|
      yield arr[i], i
    end
    self
  end

  # my_select
  def my_select
    return to_enum(:my_select) unless block_given?

    arr = []
    my_each { |el| arr.push(el) if yield el }
    arr
  end

  # my_all
  def my_all?(my_arg = nil)
    if block_given?
      to_a.my_each { |el| return false if yield(el) == false }
      return true
    elsif my_arg.nil?
      to_a.my_each { |el| return false if el.nil? || el == false }
    elsif !my_arg.nil? && (my_arg.is_a? Class)
      to_a.my_each { |el| return false unless [el.class, el.class.superclass].include?(my_arg) }
    elsif !my_arg.nil? && my_arg.instance_of?(Regexp)
      to_a.my_each { |el| return false unless my_arg.match(el) }
    else
      to_a.my_each { |el| return false if el != my_arg }
    end
    true
  end

  # my_any
  def my_any?(my_arg = nil)
    if block_given?
      to_a.my_each { |el| return true if yield(el) }
      return false
    elsif my_arg.nil?
      to_a.my_each { |el| return true if el }
    elsif !my_arg.nil? && (my_arg.is_a? Class)
      to_a.my_each { |el| return true if [el.class, el.class.superclass].include?(my_arg) }
    elsif !my_arg.nil? && my_arg.instance_of?(Regexp)
      to_a.my_each { |el| return true if my_arg.match(el) }
    else
      to_a.my_each { |el| return true if el == my_arg }
    end
    false
  end

  # my_none
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

  # my_count
  def my_count(my_arg = nil)
    count = 0
    if block_given?
      to_a.my_each { |el| count += 1 if yield(el) }
    elsif !block_given? && my_arg.nil?
      count = to_a.size
    else
      count = to_a.my_select { |el| el == my_arg }.size
    end
    count
  end

  # my_map
  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given? || proc

    arr = []
    if proc
      my_each { |el| arr.push(proc.call(el)) }
    else
      my_each { |el| arr.push(yield(el)) }
    end
    arr
  end

  def my_inject(my_arg = nil, sym = nil)
    if (my_arg.is_a?(Symbol) || my_arg.is_a?(String)) && (!my_arg.nil? && sym.nil?)
      sym = my_arg
      my_arg = nil
    end

    if !block_given? && !sym.nil?
      my_each { |elt| my_arg = my_arg.nil? ? elt : my_arg.send(sym, elt) }
    else
      my_each { |elt| my_arg = my_arg.nil? ? elt : yield(my_arg, elt) }
    end
    my_arg
  end
end

def multiply_els(arr)
  arr.my_inject { |acc, cn| acc * cn }
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
