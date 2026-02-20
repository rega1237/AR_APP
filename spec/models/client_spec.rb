require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'validations' do
    subject { Client.new(name: 'Test Restaurant', slug: 'test-restaurant', contact_email: 'test@example.com') }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'generates a slug from name if missing' do
      subject.slug = nil
      subject.valid?
      expect(subject.slug).to eq('test-restaurant')
    end

    it 'generates a slug from name if empty string is provided' do
      subject.slug = ""
      subject.valid?
      expect(subject.slug).to eq('test-restaurant')
    end

    it 'is invalid with a duplicate slug' do
      Client.create!(name: 'Other', slug: 'test-restaurant', contact_email: 'other@example.com')
      expect(subject).to_not be_valid
    end

    it 'is invalid without a contact_email' do
      subject.contact_email = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid with an improperly formatted email' do
      subject.contact_email = 'not-an-email'
      expect(subject).to_not be_valid
    end
  end

  describe 'associations' do
    it 'can have a logo attached' do
      client = Client.new(name: 'Test', slug: 'test', contact_email: 'test@example.com')
      expect(client.logo).to be_an_instance_of(ActiveStorage::Attached::One)
    end
  end
end
