require "rails_helper"

RSpec.describe "Anagrams API", type: :request do
  it 'get anagrams' do
    create :word, value: 'dear'
    create :word, value: 'dare'
    create :word, value: 'read'

    get '/api/v1/anagrams/read.json'
    result = JSON.parse(response.body)['anagrams']

    expect(response).to be_success

    expect(result.length).to eq(2)
    expect(result[0]).to eq('dear')
    expect(result[1]).to eq('dare')
  end
end