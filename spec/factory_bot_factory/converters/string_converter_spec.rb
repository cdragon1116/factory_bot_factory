require 'spec_helper'

RSpec.describe FactoryBotFactory::Converters::StringConverter do
  let(:converter) { described_class }

  describe "#call" do
    it "should build correct attribute line" do
      expect(converter.call("key", "value")).to eq("\"value\"")
    end
  end
end
