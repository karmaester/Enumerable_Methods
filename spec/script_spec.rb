# frozen_string_literal: true

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
    hash = {}
    let (:ex1) { %w[cat dog wombat] }

    it 'when block not given returns Enumerator' do
      expect(ary.my_each_with_index).to be_an Enumerator
    end

    it 'when block given returns array' do
      expect(ary.my_each_with_index { |x| x }).to be_an Array
    end

    it 'when a range given returns object' do
      expect(range.my_each_with_index { |x| x }).to be_an Object
    end

    it 'my_each_with_index is equal to each_with_index' do
      expect(ex1.my_each_with_index { |item, index| hash[item] = index }).to eql(ex1.each_with_index { |item, index| hash[item] = index })
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

    it 'when range given returns array with values that met the condition' do
      expect(range.my_select { |x| x > 3 }).to eql([4, 5, 6, 7, 8, 9, 10])
    end
  end

  describe '#my_all?' do

    it 'return true when all items meet condition' do
      expect(arr1.my_all? { |word| word.length >= 3 } ).to eql(true) 
    end

    it 'return false when not all items meet condition' do
      expect(arr1.my_all? { |word| word.length >= 4 } ).to eql(false) 
    end

    it 'return false when RegEx not meet in condition' do
      expect(arr1.my_all? (/t/) ).to eql(false)
    end

    it 'return true if all values are numeric' do
      expect(arr2.my_all? (Numeric) ).to eql(true)
    end

    it 'return false if a value is nil or false' do
      expect(arr3.my_all? ).to eql(false)
    end

    it 'return true when an empty array is passed' do
      expect(arr4.my_all? ).to eql(true)
    end
  end
end
