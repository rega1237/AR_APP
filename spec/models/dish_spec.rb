require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe 'validations' do
    let(:client) { Client.create!(name: 'Test Client', contact_email: 'test@example.com') }
    let(:menu) { Menu.create!(name: 'Main Menu', client: client) }
    let(:category) { Category.create!(name: 'Starters', menu: menu) }
    subject { Dish.new(name: 'Bruschetta', price: 9.99, category: category) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid without a price' do
      subject.price = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid with a negative price' do
      subject.price = -5.00
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:category) }

    it 'can have a photo attached' do
      dish = Dish.new(name: 'Photo Dish', price: 10.00)
      expect(dish.photo).to be_an_instance_of(ActiveStorage::Attached::One)
    end

    it 'can have a 3D model attached' do
      dish = Dish.new(name: '3D Dish', price: 10.00)
      expect(dish.model_3d).to be_an_instance_of(ActiveStorage::Attached::One)
    end
  end
end
