require 'rails_helper'

RSpec.describe Api::DataController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns JSON format' do
      get :index
      expect(response.content_type).to eq 'application/json; charset=utf-8'
    end

    it 'returns data in the correct format' do
       person = Person.create(name: 'John Doe', cpf: '12345678901', state: 'California', value: '500')

      get :index
      expect(JSON.parse(response.body)['result']).to include('John Doe')
    end
  end
 
end
