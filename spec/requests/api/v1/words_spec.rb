require "rails_helper"

RSpec.describe "Words API", type: :request do
  it 'posts an array of words' do
    post '/api/v1/words', words: ["read", "dear", "dare"]
    
    result = JSON.parse(response.body)

    expect(response).to be_success
    expect(result.length).to eq(3)
    expect(result.first['value']).to eq('read')
    expect(result.second['value']).to eq('dear')
    expect(result.third['value']).to eq('dare')
  end
end
