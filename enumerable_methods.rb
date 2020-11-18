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
end
