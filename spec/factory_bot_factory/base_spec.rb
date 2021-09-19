require 'spec_helper'

class User
  attr_accessor :id, :name
  def attributes
    {
      id: 1,
      name: 'CDragon' }
  end
end

RSpec.describe FactoryBotFactory::Base do
  it "has a version number" do
    expect(FactoryBotFactory::VERSION).not_to be nil
  end

  describe "#build" do
    let(:data) { { id: 1 } }

    context "when invalid args" do
      it "should raise error" do
        expect {
          described_class.build(123)
        }.to raise_exception(ArgumentError)
      end
    end

    context "when first arg is data" do
      it "support construct args by first arg" do
        user = User.new

        expect(FactoryBotFactory::ModelFactory)
          .to receive(:new)
          .with(factory_name: 'user', klass: User)
          .and_call_original

        expect_any_instance_of(FactoryBotFactory::ModelFactory)
          .to receive(:generate)
          .with(user)

        described_class.build(user)
      end

      context "when hash" do
        it "support construct args by first arg" do
          expect(FactoryBotFactory::OpenStructFactory)
            .to receive(:new)
            .with(factory_name: 'hash', klass: OpenStruct)
            .and_call_original

          expect_any_instance_of(FactoryBotFactory::OpenStructFactory)
            .to receive(:generate)
            .with({ test: 1 })

          described_class.build({ test: 1 }, klass: OpenStruct)
        end
      end
    end
  end
end
