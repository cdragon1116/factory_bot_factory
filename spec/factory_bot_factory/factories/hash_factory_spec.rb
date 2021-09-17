require 'spec_helper'
require "shared_context/factory"

RSpec.describe FactoryBotFactory::HashFactory do
  include_context :factory

  describe '#build' do
    let(:output) { described_class.new(factory_name: factory_name).generate(data) }
    let(:data) do
      {
        id: 1,
        name: "CDragon",
        first_name: nil,
        tags: ["tag1", "tag2"],
        address: {
          billing_address: {
            country: "Taiwan"
          }
        }
      }
    end

    it "should build factory" do
      expect(FactoryBot.build(factory_name)).to eq(data)
    end

    context "when nested level" do
      let(:output) { described_class.new(factory_name: factory_name, nested_level: 3).generate(data) }

      it "should build nested factory" do
        expect(FactoryBot.build(factory_name)).to eq(data)
        expect(FactoryBot.build(:my_class_address)).to eq(data[:address])
        expect(FactoryBot.build(:my_class_address_billing_address)).to eq(data[:address][:billing_address])
      end
    end
  end
end
