# rubocop: disable Metrics/ModuleLength, Metrics/MethodLength, Style/RedundantParentheses, Style/CaseEquality, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/IdenticalConditionalBranches, Style/IfInsideElse

module Enumerable
  def my_each
    var = to_a
    return to_enum(:my_each) unless block_given?

    index = 0
    while index < var.length
      yield(var[index])
      index += 1
    end
    self
  end

  def my_each_with_index
    var = to_a
    return to_enum(:my_each) unless block_given?

    index = 0
    while index < var.length
      yield(var[index], index)
      index += 1
    end
    self
  end

  def my_select
    var = to_a
    new_arr = []
    return to_enum(:my_select) unless block_given?

    var.my_each do |x|
      new_arr.push(x) if yield(x) == true
    end
    new_arr
  end

  def my_all?(pattern = nil)
    var = to_a
    if block_given?
      var.my_select { |x| yield(x) }.length == var.length
    elsif !pattern.nil?
      if pattern.is_a? Regexp
        var.my_select { |x| !pattern.match(x).nil? }.length == var.length
      elsif pattern.is_a? Numeric
        var.my_select { |x| pattern === x }.length == var.length
      else
        var.my_select { |x| pattern === x }.length == var.length
      end
    else
      var.my_select { |x| !x.nil? && x != false }.length == var.length
    end
  end

  def my_any?(pattern = nil)
    var = to_a
    if block_given?
      var.my_select { |x| yield(x) }.length.positive? ? true : false
    elsif !pattern.nil?
      if pattern.is_a? Regexp
        var.my_select { |x| !pattern.match(x).nil? }.length.positive? ? true : false
      elsif pattern.is_a? Numeric
        var.my_select { |x| pattern === x }.length.positive? ? true : false
      else
        var.my_select { |x| pattern === x }.length.positive? ? true : false
      end
    else
      var.my_select { |x| !x.nil? && x != false }.length.positive? ? true : false
    end
  end

  def my_none?(pattern = nil)
    var = to_a
    if block_given?
      var.my_select { |x| yield(x) }.length.zero? ? true : false
    elsif !pattern.nil?
      if pattern.class == Regexp
        var.my_select { |x| !pattern.match(x).nil? }.length.zero? ? true : false
      elsif pattern.class == Integer
        var.my_select { |x| pattern === x }.length.zero? ? true : false
      else
        var.my_select { |x| pattern === x }.length.zero? ? true : false
      end
    else
      var.my_select { |x| !x.nil? && x != false }.length.zero? ? true : false
    end
  end

  def my_count(arg = nil)
    var = to_a
    if arg.nil?
      return var.length unless block_given?

      var.my_select { |x| yield(x) }.length
    else
      var.my_select { |x| x == arg }.length
    end
  end

  def my_map(proc = nil)
    var = to_a
    new_arr = []
    if !proc.nil?
      var.my_each do |x|
        new_arr.push(proc.call(x))
      end
    else
      return to_enum(:my_map) unless block_given?

      var.my_each do |x|
        new_arr.push(yield(x))
      end
    end
    new_arr
  end

  def my_inject(*args)
    var = to_a

    count = if var.my_all? { |x| x.class == String }
              ''
            else
              args
            end

    if args.length == 2
      count = args[0]
      operation = args[1]
      var.my_each do |x|
        count = count.send operation, x
      end
      count
    elsif args.length == 1 && args[0].class == Symbol
      count = 0
      count = 1 if args[0] == (:*) || args[0] == (:/)
      operation = args[0]
      var.my_each do |x|
        count = count.send operation, x
      end
      count
    elsif args.length == 1 && args[0].class == Integer
      raise LocalJumpError, 'no block given' unless block_given?

      count = args[0]
      var.my_each do |x|
        count = yield(count, x)
      end
      count
    else
      if !count.is_a? String
        raise LocalJumpError, 'no block given' unless block_given?

        count = var[0]
        var_mod = var.dup
        var_mod.shift
        var_mod.my_each do |el|
          count = yield(count, el)
        end
        count
      else
        raise LocalJumpError, 'no block given' unless block_given?

        var.my_each do |x|
          count = yield(count, x)
        end
        count
      end
    end
  end
end

def multiply_els(arr)
  arr.my_inject(1, :*)
end

p [1, 2, 3].my_each

# rubocop: enable Metrics/ModuleLength, Metrics/MethodLength, Style/RedundantParentheses, Style/CaseEquality, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/IdenticalConditionalBranches, Style/IfInsideElse
