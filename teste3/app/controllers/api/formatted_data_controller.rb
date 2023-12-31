
class Api::FormattedDataController < ApplicationController
    require 'yaml'
  
    def index
        input_data = [
            { name: 'João Silva', cpf: '12345678901', state: 'Rio de Janeiro', value: '9876' },
            { name: 'Ana Santos', cpf: '23456789012', state: 'Bahia', value: '5432' },
            { name: 'Carlos Oliveira', cpf: '34567890123', state: 'Pernambuco', value: '1234' },
            { name: 'Mariana Lima', cpf: '45678901234', state: 'Amazonas', value: '8765' },
            { name: 'Lucas Pereira', cpf: '56789012345', state: 'Ceará', value: '4321' },
            { name: 'Fernanda Souza', cpf: '67890123456', state: 'Pará', value: '5678' },
            { name: 'Gabriel Costa', cpf: '78901234567', state: 'Acre', value: '9876' },
            { name: 'Isabela Almeida', cpf: '89012345678', state: 'Amapá', value: '5432' },
            { name: 'Rodrigo Santos', cpf: '90123456789', state: 'Roraima', value: '1234' },
            { name: 'Camila Oliveira', cpf: '01234567890', state: 'Tocantins', value: '8765' },
            { name: 'Felipe Lima', cpf: '10987654321', state: 'Maranhão', value: '4321' },
            { name: 'Larissa Pereira', cpf: '21098765432', state: 'Paraíba', value: '5678' },
            { name: 'Eduardo Souza', cpf: '32109876543', state: 'Piauí', value: '9876' },
            { name: 'Amanda Costa', cpf: '43210987654', state: 'Santa Catarina', value: '5432' },
            { name: 'Vinícius Almeida', cpf: '54321098765', state: 'Sergipe', value: '1234' },
            { name: 'Juliana Santos', cpf: '65432109876', state: 'Tocantins', value: '8765' },
            { name: 'Rafael Lima', cpf: '76543210987', state: 'Rio Grande do Sul', value: '4321' },
            { name: 'Carolina Oliveira', cpf: '87654321098', state: 'Rondônia', value: '5678' },
            { name: 'Daniel Pereira', cpf: '98765432109', state: 'Paraná', value: '9876' },
            { name: 'Patrícia Souza', cpf: '09876543210', state: 'Minas Gerais', value: '5432' }
          ]
          
  
      format_config = load_format_config
      puts "Format Config: #{format_config}"
  
      formatted_data = solucao_formatar(input_data, format_config)
      render json: { result: formatted_data }
    end
  
    private
    def solucao_formatar(arg, format_config)
        result = ""
      
        arg.each do |person|
          puts "Person: #{person}"
      
          line = ""
      
          format_config.keys.each do |key|
            field_config = format_config[key]
            value = person[key.to_sym].to_s
            length = field_config['length']
            align = field_config['align']
            padding = field_config['padding']
      
            value = value[0, length] if value.length > length
      
            formatted_value = align == 'right' ? value.rjust(length, padding == 'zeroes' ? '0' : ' ') : value.ljust(length, padding == 'zeroes' ? '0' : ' ')
      
            puts "Key: #{key}, Person: #{person}, Original Value: #{value}, Formatted Value: #{formatted_value}, Line So Far: #{line}"
      
            line += formatted_value
          end
      
          puts "Final Line: #{line}"
          result += "#{line}\n"
        end
      
        result
      end
      
  
    def load_format_config
      YAML.load_file('config/format.yaml')
    end
  end
  