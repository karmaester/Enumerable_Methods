require '../script.rb'

RSpec.describe Enumerable do
  describe '#my_each' do
    let(:ary) { [1, 2, 3, 4, 5] }
    let(:range) { (1..10) }

    it 'when block not given returns Enumerator' do
        expect(ary.my_each).to be_an Enumerator
    end

    it 'when block given' do
        expect(ary.my_each {|x| x}).to be_an Array
    end

    it 'when a range given' do
        expect(range.my_each {|x| x}).to be_an Object
    end
  end
end