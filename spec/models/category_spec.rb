require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    let(:client) { Client.create!(name: 'Test Client', contact_email: 'test@example.com') }
    let(:menu) { Menu.create!(name: 'Main Menu', client: client) }
    subject { Category.new(name: 'Starters', menu: menu, position: 1) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:menu) }
    it { should have_many(:dishes).dependent(:destroy) }
  end
end
