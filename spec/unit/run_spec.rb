# frozen_string_literal: true

RSpec.describe Benchmark::Malloc do
  it "traces only new object allocations" do
    %i[foo bar baz].freeze

    sample = described_class.trace do
      %i[foo bar baz].freeze
    end

    expect(sample.allocated.total_objects).to eq(1)
    expect(sample.allocated.total_memory).to be <= 40
  end

  it "traces block assigned instances" do
    memory = described_class.new

    sample = memory.run do
      _new_object = Object.new
      _new_array  = [:baz]
      _new_string = 'foo' + 'baz'
    end

    # allocated
    expect(sample.allocated.total_objects).to be <= 5
    expect(sample.allocated.total_memory).to be <= 200

    expect(sample.allocated.count_objects[Object]).to eq(1)
    expect(sample.allocated.count_objects[Array]).to eq(1)
    expect(sample.allocated.count_objects[String]).to be <= 3

    expect(sample.allocated.count_memory[Object]).to be <= 40
    expect(sample.allocated.count_memory[String]).to be <= 120
    expect(sample.allocated.count_memory[Array]).to be <= 40

    # retained
    expect(sample.retained.total_objects).to be <= 5
    expect(sample.retained.total_memory).to be <= 200

    expect(sample.retained.count_objects[Object]).to eq(1)
    expect(sample.retained.count_objects[Array]).to eq(1)
    expect(sample.retained.count_objects[String]).to be <= 3

    expect(sample.retained.count_memory[Object]).to be <= 40
    expect(sample.retained.count_memory[String]).to be <= 120
    expect(sample.retained.count_memory[Array]).to be <= 40
  end

  it "traces large number of objects" do
    result = described_class.trace do
      10.times { |i| [i.to_s, {}] }
    end

    expect(result.allocated.total_objects).to eq(10 * 3)
    expect(result.allocated.total_memory).to be <= (3120)
    expect(result.allocated.count_objects).to eq({
      Array => 10, String => 10, Hash => 10})

    # memory
    expect(result.allocated.count_memory[Array]).to be <= 400
    expect(result.allocated.count_memory[String]).to be <= 400
    expect(result.allocated.count_memory[Hash]).to be <= 2400
  end

  it "raises when stopped without starting" do
    expect {
      described_class.new.stop
    }.to raise_error(Benchmark::Malloc::Error, "not started yet")
  end

  it "raises when started again" do
    expect {
      malloc = described_class.new
      malloc.start
      malloc.start
    }.to raise_error(Benchmark::Malloc::Error, "already running")
  end
end
