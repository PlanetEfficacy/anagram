require "rails_helper"

RSpec.describe "Words API", type: :request do
  it 'posts an array of words' do
    post '/api/v1/words', words: ["read", "dear", "dare"]
    words = JSON.parse(response.body)

    expect(response).to be_success
    expect(words.length).to eq(3)
    
    expect(words.first['value']).to eq('read')
    expect(words.second['value']).to eq('dear')
    expect(words.third['value']).to eq('dare')
  end
end
