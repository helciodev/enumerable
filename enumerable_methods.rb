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
end