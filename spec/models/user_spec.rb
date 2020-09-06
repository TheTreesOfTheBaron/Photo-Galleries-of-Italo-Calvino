require 'rails_helper'

RSpec.describe User, type: :model do
  context 'before sign in' do
    it 'cannot create photo' do
      expect { Photo.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
