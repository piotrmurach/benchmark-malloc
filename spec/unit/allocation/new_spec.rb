# frozen_string_literal: true

RSpec.describe Benchmark::Malloc::Allocation do
  it "gathers info about allocated object" do
    object = Object.new
    alloc = described_class.new(object)

    expect(alloc.memsize).to be <= 40
    expect(alloc.source_line).to eq(nil)
    expect(alloc.method_id).to eq(nil)
    expect(alloc.class_path).to eq(nil)
    expect(alloc.source_file).to eq(nil)
  end

  it "extracts allocation info" do
    object = Object.new
    alloc = described_class.new(object)

    extracted = alloc.extract(:class, :memsize)

    expect(extracted[0]).to eq(Object)
    expect(extracted[1]).to be <= 40
  end
end
