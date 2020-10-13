# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength, Layout/LineLength

require '../script.rb'

RSpec.describe Enumerable do
  let(:ary) { [1, 2, 3, 4, 5] }
  let(:range) { (1..10) }
  let(:arr1) { %w[ant bear cat] }
  let(:arr2) { [1, 2i, 3.14] }
  let(:arr3) { [nil, true, 99] }
  let(:arr4) { [] }

  describe '#my_each' do
    it 'when block not given returns Enumerator' do
      expect(ary.my_each).to be_an Enumerator
    end

    it 'when block given returns array' do
      expect(ary.my_each { |x| x }).to be_an Array
    end

    it 'when a range given returns Object' do
      expect(range.my_each { |x| x }).to be_an Object
    end
  end
  describe '#my_each_with_index' do
    it 'when block not given returns Enumerator' do
      expect(ary.my_each_with_index).to be_an Enumerator
    end

    it 'when block given returns array' do
      expect(ary.my_each_with_index { |x| x }).to be_an Array
    end

    it 'when a range given returns object' do
      expect(range.my_each_with_index { |x| x }).to be_an Object
    end
  end
  describe '#my_select' do
    it 'when block not given returns Enumerator' do
      expect(ary.my_select).to be_an Enumerator
    end

    it 'when block given returns array' do
      expect(ary.my_select { |x| x }).to be_an Array
    end

    it 'when range given returns array' do
      expect(range.my_select { |x| x }).to be_an Array
    end

    it 'my_select is equal to select' do
      expect(ary.my_select { |x| x > 3 }).to eql(ary.select { |x| x > 3 })
    end

    it 'when range given returns array with values that meet the condition' do
      expect(range.my_select { |x| x > 3 }).to eql([4, 5, 6, 7, 8, 9, 10])
    end
  end
  describe '#my_all?' do
    it 'return true when all items meet condition' do
      expect(arr1.my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'return false when not all items meet condition' do
      expect(arr1.my_all? { |word| word.length >= 4 }).to eql(false)
    end

    it 'return false when RegEx not meet in condition' do
      expect(arr1.my_all?(/t/)).to eql(false)
    end

    it 'return true if all values are numeric' do
      expect(arr2.my_all?(Numeric)).to eql(true)
    end

    it 'return false if a value is nil or false' do
      expect(arr3.my_all?).to eql(false)
    end

    it 'return true when an empty array is passed' do
      expect(arr4.my_all?).to eql(true)
    end
  end
  describe '#my_any?' do
    it 'return true when any of the items meet condition' do
      expect(arr1.my_any? { |word| word.length >= 3 }).to eql(true)
    end

    it 'return true when RegEx meet in condition' do
      expect(arr1.my_any?(/t/)).to eql(true)
    end

    it 'return true if any of the values are numeric' do
      expect(arr2.my_any?(Numeric)).to eql(true)
    end

    it 'return true if a value is not nil or false' do
      expect(arr3.my_any?).to eql(true)
    end

    it 'return false when an empty array is passed' do
      expect(arr4.my_any?).to eql(false)
    end

    it 'when range given returns true if any of the values meet the condition' do
      expect(range.my_any? { |x| x > 3 }).to eql(true)
    end

    it 'when argument given returns true if any of the items equal to pattern' do
      expect(ary.my_any?(3)).to eql(true)
    end
  end
  describe '#my_none?' do
    it 'return false when any of the items meet condition' do
      expect(arr1.my_none? { |word| word.length >= 3 }).to eql(false)
    end

    it 'return false when RegEx condition meet by any value' do
      expect(arr1.my_none?(/t/)).to eql(false)
    end

    it 'return false if any of the values are numeric' do
      expect(arr2.my_none?(Numeric)).to eql(false)
    end

    it 'return false if all of the values are not nil or false and no block is given' do
      expect(arr3.my_none?).to eql(false)
    end

    it 'return true when an empty array is passed' do
      expect(arr4.my_none?).to eql(true)
    end

    it 'when range given returns false if any of the values meet the condition' do
      expect(range.my_none? { |x| x > 3 }).to eql(false)
    end

    it 'when argument given returns false if any of the items equal to pattern' do
      expect(ary.my_none?(3)).to eql(false)
    end
  end
  describe '#my_count' do
    it 'Returns the lenght of the array if no argument is given' do
      expect(ary.my_count).to eql(5)
    end

    it 'Returns the lenght of the new array with the values that are equal to the argument' do
      expect(ary.my_count(3)).to eql(1)
    end

    it 'If block given returns the lenght of the array of values that meet condition' do
      expect(ary.my_count { |x| x > 3 }).to eql(2)
    end

    it 'If block and range given returns the lenght of the array of values that meet condition' do
      expect(range.my_count { |x| x > 3 }).to eql(7)
    end

    it 'Returns 0 if the array is empty' do
      expect(arr4.my_count).to eql(0)
    end
  end

  describe '#my_map' do
    prc = proc { 'v' }
    it 'when block not given returns Enumerator' do
      expect(ary.my_map).to be_an Enumerator
    end

    it 'when block given returns new array with new values' do
      expect(ary.my_map { |x| x + 1 }).to eql([2, 3, 4, 5, 6])
    end

    it 'when block and range given returns new array with new values' do
      expect(range.my_map { 'v' }).to eql(%w[v v v v v v v v v v])
    end

    it 'when proc and range given returns new array with new values' do
      expect(range.my_map(prc)).to eql(%w[v v v v v v v v v v])
    end
  end

  describe '#my_inject' do
    it 'when symbol passed as argument it performs the operation and returns the result' do
      expect(range.my_inject(:+)).to eql(55)
    end

    it 'when block given it performs the operation and returns the result' do
      expect(range.my_inject { |sum, n| sum + n }).to eql(55)
    end

    it 'when two arguments passed, first is initial value and second operator' do
      expect(range.my_inject(1, :+)).to eql(56)
    end

    it 'when argument and block given, argument is initial value and block the operator' do
      expect(range.my_inject(1) { |product, n| product + n }).to eql(56)
    end

    it 'find the longest word using a ternary as a block' do
      expect(%w[cat sheep bear].my_inject { |memo, word| memo.length > word.length ? memo : word }).to eql('sheep')
    end
  end
end

# rubocop:enable Metrics/BlockLength, Layout/LineLength
