require '../script.rb'

include Enumerable do
  describe '#my_each' do
    let(:ary) { [1, 2, 3, 4, 5] }

    it 'When block not given' do
      expect(ary.my_each(&block)).to eql(ary.my_each(&block))
    end
  end
end
