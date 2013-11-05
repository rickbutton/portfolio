require 'spec_helper'
describe Item do

  subject(:item) { create :item }

  
  it 'has a valid factory' do 
    expect(item).not_to be_nil
  end

  [:name,
   :base_dir,
   :description,
   :slug].each do |col|
    it "is invalid without #{col}" do
      item = build :item, col => nil
      expect(item.save).to be_false
    end
  end
  describe "#to_param" do
    it {expect(item.to_param).to eq item.slug}
  end

  describe "#root_dir" do
    it 'only calls DirectoryEntry.new once' do
      expect(DirectoryEntry).to receive(:new).once
      item.root_dir
    end
  end
end
