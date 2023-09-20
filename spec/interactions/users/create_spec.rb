# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Create, '#execute' do
  let!(:params) do
    {
      name: 'Имя',
      surname: 'Фамилия',
      patronymic: 'Отчество',
      full_name: 'Фамилия Имя Отчество',
      age: 33,
      email: 'user@mail.original',
      country: 'Russia',
      nationality: 'Russian',
      interests: %w[benchrest curling],
      skills: ['leap of faith', 'immortality'],
      gender: %w[male female].sample
    }
  end

  subject(:interaction) { described_class.run(params) }

  it 'works' do
    expect(interaction).to be_valid
  end

  it 'persists new user record' do
    expect { interaction }.to change(User, :count).by(1)
  end

  it 'persists 2 new skill records' do
    expect { interaction }.to change(Skill, :count).by(2)
  end

  it 'persists 2 new interest records' do
    expect { interaction }.to change(Interest, :count).by(2)
  end
end
