require 'spec_helper'

RSpec.describe FactoryBotFactory::ActiveRecordFactory do
  let(:post) { Post.create(title: 'my first post') }
  include_context :factory

  describe '#build' do
    let(:output) { described_class.new(factory_name: factory_name).generate(data) }
    let(:data) { post }

    it "should build factory" do
      expect(FactoryBot.build(factory_name).class).to eq(Post)
    end
  end
end
