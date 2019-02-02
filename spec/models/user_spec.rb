require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_uniqueness_of(:name)}
    it {should validate_length_of(:name).is_at_least 1}
  end

  describe 'relationships' do
    it {should have_many :reviews}
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
  end
end
