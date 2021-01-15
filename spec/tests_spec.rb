require './main'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4] }
  let(:arr_s) { %w[hello hi bye] }
  let(:ha) { { 'key1' => 'green', 'key2' => 'purple', 'key3' => 'black' } }
  let(:ran) { (0..10) }
  let(:my_array2) { [] }
  let(:test) { [true, false, nil] }

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
        expect(ha.my_select { |_k, v| v.length == 5 }).to eql({ 'key1' => 'green', 'key3' => 'black' })
      end
    end
  end

  describe '#my_all' do
    it 'should return an Enumerator if block is not given' do
      expect(arr.my_all?).to eql(true)
    end
    it 'should return an array given the condition' do
      expect(arr.my_all? { |elem| elem > 1 }).to eql(false)
    end
  end

  describe '#my_any' do
    it 'returns true if not given and atleast has one element not false or nil' do
      expect(my_array2.my_any?).to eql(false)
    end
    it 'returns false based on the condition in the block' do
      expect(arr.my_any? { |elem| elem > 10 }).to eql(false)
    end
    it 'returns true if the block returns a value other than false or nil' do
      expect(arr.my_any? { |elem| elem < 10 }).to eql(true)
    end
  end

  describe '#my_none' do
    it 'returns true if the block is not given, and none of the collection members is true' do
      expect(test.my_none?).to eql(false)
    end

    it 'returns true if the block never returns true' do
      expect(arr.my_none? { |elem| elem > 10 }).to eql(true)
    end
  end

  describe '#my_count' do
    it 'returns number of elements in a list if a block is not given' do
      expect(arr.my_count).to eql(4)
    end

    it 'if passed argument, returns number of elements equal to argument' do
      expect(arr.my_count(4)).to eql(1)
    end
  end

  describe '#my_map' do
    it 'returns and enumerator if no block is given ' do
      expect(arr.my_map).to be_an(Enumerator)
    end

    it 'if block is given returns an array based on the block' do
      expect(arr.my_map { |elem| elem * 3 }).to eql([3, 6, 9, 12])
    end
  end

  describe '#my_inject' do
    it 'if a symbol is given, returns a value based on the symbol' do
      expect(ran.my_inject(:+)).to eql(55)
    end

    it 'if a block is given returns a value based on the block' do
      expect(ran.my_inject { |sum, num| sum + num }).to eql(55)
    end
  end

  describe '#multiply_els' do
    it 'return product of the elements' do
      expect(multiply_els(ran)).to eql(0)
    end
  end
end
