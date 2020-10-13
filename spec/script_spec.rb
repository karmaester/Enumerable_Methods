require '../script.rb'

RSpec.describe Enumerable do
    let(:ary) { [1, 2, 3, 4, 5] }
    let(:range) { (1..10) }
  describe '#my_each' do
    it 'when block not given returns Enumerator' do
        expect(ary.my_each).to be_an Enumerator
    end

    it 'when block given returns array' do
        expect(ary.my_each {|x| x}).to be_an Array
    end

    it 'when a range given returns block' do
        expect(range.my_each {|x| x}).to be_an Object
    end
  end
  describe '#my_each_with_index' do
    it 'when block not given returns Enumerator' do
        expect(ary.my_each_with_index).to be_an Enumerator
    end

    it 'when block given returns array' do
        expect(ary.my_each_with_index {|x| x}).to be_an Array
    end

    it 'when a range given returns block' do
        expect(range.my_each_with_index {|x| x}).to be_an Object
    end
  end
  describe '#my_select' do
    it 'when block not given returns Enumerator' do
        expect(ary.my_select).to be_an Enumerator
    end
  end
end