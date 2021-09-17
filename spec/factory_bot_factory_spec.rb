require 'spec_helper'

RSpec.describe FactoryBotFactory do
  it "has a version number" do
    expect(FactoryBotFactory::VERSION).not_to be nil
  end

  describe "#build" do
    let(:data) { { id: 1 } }
    it "should build factory" do
      expect_any_instance_of(FactoryBotFactory::HashFactory)
        .to receive(:generate)
        .with(data)

      described_class.build(:my_class, "Hash", data)
    end
  end
end
