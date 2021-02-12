# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'List', type: :model do
  describe 'Model test' do
    it 'create with valid post' do
      expect(build(:list)).to be_valid
    end
  end
end
