# frozen_string_literal: true

RSpec.describe Benchmark::Malloc::Allocation do
  it "gathers info about allocated object" do
    object = Object.new
    alloc = described_class.new(object)

    expect(alloc.memsize).to eq(40)
    expect(alloc.source_line).to eq(nil)
    expect(alloc.method_id).to eq(nil)
    expect(alloc.class_path).to eq(nil)
    expect(alloc.source_file).to eq(nil)
  end

  it "extracts allocation info" do
    object = Object.new
    alloc = described_class.new(object)

    expect(alloc.extract(:class, :memsize)).to eq([Object, 40])
  end
end
