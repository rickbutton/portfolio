require 'spec_helper'
require "json"

describe ItemsController do
  subject(:items) { [create(:item), create(:item), create(:item)]}
  subject(:item)  { create(:item) }
  before do
    Item.any_instance.stub(:root_dir) { build(:directory_entry)  }
    Item.stub(:where).with(slug: item.slug) { [item] }
    Item.stub(:order).with(:order) { items }
  end

  describe "GET index" do
    it 'assigns @items ordered' do
      get :index
      expect(assigns(:items)).to eq(items)
    end
    context 'in browser' do
      it 'renders the index template' do
        get :index
        expect(response).to render_template("index")
      end
    end
    context 'json' do
      it 'renders the correct json' do
        get :index, format: :json
        json = JSON.parse(response.body)
        expect(json.has_key?("items")).to be_true
      end
    end
  end

  describe 'GET show' do
    it 'assigns @item' do
      get :show, id: item.slug
      expect(assigns(:item)).to eq(item)
    end
    context 'in browser' do
      it 'renders the index template' do
        get :show, id: item.slug
        expect(response).to render_template("show")
      end
    end
    context 'json' do
      it 'renders the correct json' do
        get :show, id: item.slug, format: :json
        json = JSON.parse(response.body)
        expect(json.has_key?("directory_entry")).to be_true
      end
    end
  end

  describe 'GET path' do
    it 'renders the correct json' do
      get :path, id: item.slug, path: 'dir1/sd1'            
      json = JSON.parse(response.body)
      expect(json.has_key?("directory_entry")).to be_true
      expect(json["directory_entry"]["name"]).to eq("sd1")
    end
    it 'returns 404 when path invalid' do
      expect {get :path, id: item.slug, path: 'dir1/sf1'}.to raise_error ActionController::RoutingError
      expect {get :path, id: item.slug, path: 'dir1/foo'}.to raise_error ActionController::RoutingError
    end
  end

  describe 'GET content' do
    it 'renders the correct json' do
      FileEntry.any_instance.stub(:content) { "test" }
      get :content, id: item.slug, path: 'dir1/sf1'
      json = JSON.parse(response.body)
      expect(json.has_key?("file_entry_content")).to be_true
      expect(json["file_entry_content"]["content"]).to eq("test")
    end
    it 'returns 404 when path invalid' do
      expect {get :content, id: item.slug, path: 'dir1/sd1'}.to raise_error ActionController::RoutingError
      expect {get :content, id: item.slug, path: 'dir1/foo'}.to raise_error ActionController::RoutingError
    end

  end
end
