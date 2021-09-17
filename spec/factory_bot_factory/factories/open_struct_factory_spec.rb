require 'spec_helper'

RSpec.describe FactoryBotFactory::OpenStructFactory do
  include_context :factory

  describe '#build' do
    let(:output) { described_class.new(factory_name: factory_name).generate(data) }
    let(:data) do
      {
        id: 1,
        name: "CDragon",
        tags: ["tag1", "tag2"],
        address: {
          billing_address: {
            country: "Taiwan"
          }
        }
      }
    end

    it "should build factory" do
      instance = FactoryBot.build(factory_name)
      expect(instance.class).to eq(OpenStruct)
      expect(instance.id).to eq(1)
      expect(instance.name).to eq("CDragon")
      expect(instance.tags).to eq(["tag1", "tag2"])
    end

    context "when nested level" do
      let(:output) { described_class.new(factory_name: factory_name, nested_level: 2).generate(data) }

      it "should build nested factory" do
        expect(FactoryBot.build(factory_name).class).to eq(OpenStruct)
        expect(FactoryBot.build(:my_class_address).class).to eq(OpenStruct)
      end
    end
  end
end
