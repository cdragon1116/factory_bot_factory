require 'spec_helper'

class User
  attr_accessor :id, :name
  def attributes
    {
      id: 1,
      name: 'CDragon'
    }
  end
end

RSpec.describe FactoryBotFactory::ModelFactory do
  include_context :factory

  describe '#build' do
    let(:output) { described_class.new(factory_name: factory_name).generate(data) }
    let(:data) { User.new }

    it "should build factory" do
      expect(FactoryBot.build(factory_name).class).to eq(User)
    end
  end
end
