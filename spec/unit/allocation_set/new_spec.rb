# frozen_string_literal: true

RSpec.describe Benchmark::Malloc::AllocationSet do

  def make_allocation(object)
    Benchmark::Malloc::Allocation.new(object)
  end

  it "counts allocated objects" do
    object_alloc = make_allocation(Object.new)
    hash_alloc = make_allocation({Object.new => :foo})
    string_alloc = make_allocation(:bar)

    allocations = [object_alloc, hash_alloc, string_alloc]
    alloc_set = described_class.new(allocations)

    expect(alloc_set.count_objects).to eq({Hash => 1, Object => 1, Symbol => 1})
    expect(alloc_set.total_objects).to eq(3)
  end

  it "counts allocated memory" do
    object_alloc = make_allocation(Object.new)
    hash_alloc = make_allocation({Object.new => :foo})
    string_alloc = make_allocation(:bar)

    allocations = [object_alloc, hash_alloc, string_alloc]
    alloc_set = described_class.new(allocations)

    expect(alloc_set.count_memory[Hash]).to be < 240
    expect(alloc_set.count_memory[Object]).to be <= 40
    expect(alloc_set.count_memory[Symbol]).to eq 0

    expect(alloc_set.total_memory).to be < 300
  end

  it "filters allocated objects" do
    object_alloc = make_allocation(Object.new)
    hash_alloc = make_allocation({Object.new => :foo})
    string_alloc = make_allocation(:bar)

    allocations = [object_alloc, hash_alloc, string_alloc]
    alloc_set = described_class.new(allocations)

    expect(alloc_set.filter(Object)).to eq([object_alloc])
  end
end
