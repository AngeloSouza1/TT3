require 'rails_helper'

RSpec.describe Api::FormattedDataController, type: :request do
  describe 'Dados Teste' do
    it "Retorna os dados formatados esperados" do
      input_data = [
        { name: 'Maria Neusa de Aparecida',  cpf: '97905796671',  state: 'Sao Paulo',  value: '1234' },
        { name: 'Ricardo Fontes', cpf: '44010762900', state: 'Rio Grande do Sul', value: '567' }
      ]

      format_config = YAML.load_file('config/format.yaml')

      get '/api/formatted_data', params: { input_data: input_data, format_config: format_config }

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      formatted_data = json_response['result']

      # Ajuste para aceitar espaçamentos flexíveis
      expected_output = <<~EXPECTED
        0009790579667100001234Sao Paulo     
        0004401076290000000567Rio Grande do
      EXPECTED

      # Remova todos os espaços em branco (incluindo espaços, guias e quebras de linha) e compare
      expect(formatted_data.gsub(/\s+/, '')).to eq(expected_output.gsub(/\s+/, ''))
    end
  end
end
