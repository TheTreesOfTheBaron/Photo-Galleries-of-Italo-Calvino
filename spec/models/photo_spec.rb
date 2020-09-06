require 'rails_helper'

RSpec.describe Photo, type: :model do
  context 'after sign in' do
    it 'can show' do
      expect { Photo.show }
    end
    it 'can create' do
      expect { Photo.create }
    end
    it 'can destroy' do
      expect { Photo.destroy(id) }
    end
    it 'can multiple_destroy' do
      expect { Photo.destroy_multiple }
    end
    it 'can update' do
      expect { Photo.update(id) }
    end
    it 'can edit' do
      expect { Photo.edit(id) }
    end
    it 'can index' do
      expect { Photo.index }
    end
  end

  context 'before sign in' do
    it 'cannot create photo' do
      expect { Photo.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'after being created' do
      it 'should have title' do
        expect { Photo.title }
      end
      it 'should have images' do
        expect { Photo.images }
      end
      it 'should have visibility' do
        expect { Photo.visibility }
      end
  end
end
