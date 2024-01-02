# spec/controllers/api/formatted_data_inverse_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::FormattedDataInverseController, type: :controller do
  describe 'POST #solucao_inversa' do
    it 'retorna os resultados esperados' do
      format_config = {
        'cpf' => { 'length' => 11 },
        'name' => { 'length' => 14 },
        'value' => { 'length' => 8 }
      }

      allow(controller).to receive(:load_format_config).and_return(format_config)

      input_strings = [
        { 'input_string' => '97905796671Maria Neusa de00001234' },
        { 'input_string' => '12345678901John Doe      00004567' }
      ]

      post :solucao_inversa, params: { _json: input_strings }

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      results = json_response

      expected_results = [
        { "result" => { "cpf" => "97905796671", "name" => "Maria Neusa de", "value" => "00001234" } },
        { "result" => { "cpf" => "12345678901", "name" => "John Doe", "value" => "00004567" } }
      ]
      
      # Verifique se os resultados coincidem
      expect(json_response).to eq(expected_results)
   
    end
  end
end
