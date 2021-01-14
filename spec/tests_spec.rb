require './main.rb'

describe Enumerable do
    let(:arr) { [1, 2, 3, 4] }
    let(:arr_s) {['hello','hi','bye']}
    let(:ha) { { 'key1' => 'green', 'key2' => 'purple', 'key3' => 'black' } }
    let(:ran) { (0..10) }

context 'Enumerable method that works like the original' do

    describe '#my_each' do
    
        it 'return an enumerator if no block is given' do
        expect(arr.my_each.is_a?(Enumerator)).to eql(true)
        end

        it 'iterate to each one of the elements of an array' do
        i = 0
        arr.my_each do |el|
          expect(el).to eql(arr[i])
          i += 1
        end
        end

        it 'iterate to each one of the elements of a hash' do
        ha.my_each do |key, val|
          expect(val).to eql(ha[key])
        end
        end

        it 'calls the given block once for each element and does not return a new array' do
        result = arr.my_each { |number| number * 2 }
        expect(result).to_not eq([2, 4, 6, 8])
        end
        end

        it 'calls the given block once for each element and returns array itself' do
          result = arr.my_each { |number| number * 2 }
          expect(result).to eq([1, 2, 3, 4])
        end

        context 'When an hash is given' do
          it 'returns a hash' do
            result = ha.my_each { |item| item }
            expect(result).to be_instance_of(Hash)
            end
    
          end
        
        

    describe '#my_each_with_index' do

    
      it 'returns enumerator when no block is given' do
        result = arr_s.my_each_with_index
        expect(result).to be_instance_of(Enumerator)
      end

      context 'When an array is given' do

      it 'iterate to each one of the elements of an array and check the index' do
        i = 0
        arr.my_each_with_index do |el, ind|
        expect(el).to eql(arr[i])
        expect(ind).to eql(i)
        i += 1
        end
      end

      end

    end

    describe '#my_select' do

    it 'return an enumerator if no block is given' do
      expect(arr.my_select.is_a?(Enumerator)).to eql(true)

    end

    it "return a new array according to the block's condition" do
      expect(arr.my_select(&:even?)).to eql([2, 4])
    end

    context 'when a range is given' do
    it "return a new array according to the block's condition" do
      expect(ran.my_select(&:odd?)).to eql([1, 3, 5, 7, 9])
    end
    end
    context 'when a hash is given' do
    it 'return a new hash matching keys and values' do
      expect(ha.my_select { |k, v| v.length == 5 }).to eql({ 'key1' => 'green', 'key3' => 'black' })
    end
    end

    end

end 
end