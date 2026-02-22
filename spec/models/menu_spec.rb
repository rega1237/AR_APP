require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'validations' do
    let(:client) { Client.create!(name: 'Test Client', contact_email: 'test@example.com') }
    subject { Menu.new(name: 'Main Menu', client: client) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:client) }
    it { should have_many(:categories).dependent(:destroy) }
    it { should have_many(:dishes).through(:categories) }
  end
end
