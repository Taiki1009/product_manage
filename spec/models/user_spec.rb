require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#email' do
    let(:user) { build(:user, email: email) }

    context 'valid case' do
      let(:email) { 'dev@mail.com' }

      it 'valid user' do
        expect(user.valid?).to eq(true)
        expect { user.save! }.not_to raise_error
      end
    end

    context 'invalid case' do
      describe 'presence' do
        let(:email) { '' }

        it 'can not create blank email user' do
          expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
          expect(user.errors.full_messages).to include("Email can't be blank")
        end
      end

      describe 'uniqueness' do
        let(:email) { 'dev@mail.com' }

        before { user.save! }

        it 'can not create same email user' do
          user2 = build(:user, email: email)
          expect { user2.save! }.to raise_error(ActiveRecord::RecordInvalid)
          expect(user2.errors.full_messages).to include('Email has already been taken')
        end
      end

      describe 'format' do
        shared_examples 'invalid email user' do
          it 'invalid email user' do
            expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
            expect(user.errors.full_messages).to include('Email is invalid')
          end
        end

        context 'double @' do
          let(:email) { 'dev@@mail.com' }

        include_examples 'invalid email user'
        end

        context 'invalid domain' do
          let(:email) { 'dev@hogehoge' }

          include_examples 'invalid email user'
        end
      end
    end
  end

  describe '#name' do
    let(:user) { build(:user, name: name) }

    context 'valid case' do
      let(:name) { 'a' * 25 }

      it 'valid user' do
        expect(user.valid?).to eq(true)
        expect { user.save! }.not_to raise_error
      end
    end

    context 'invalid case' do
      let(:name) { 'a' * 26 }

      it 'can not create too long name user' do
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        expect(user.errors.full_messages).to include('Name is too long (maximum is 25 characters)')
      end
    end
  end

  describe '#password' do
    let(:user) { build(:user, password: password) }

    context 'invalid case' do
      let(:password) { 'password' }

      it 'valid user' do
        expect(user.valid?).to eq(true)
        expect { user.save! }.not_to raise_error
      end
    end

    context 'invalid case' do
      let(:password) { '' }

      it 'can not blank password user' do
        expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
        expect(user.errors.full_messages).to include("Password can't be blank")
      end
    end
  end
end
