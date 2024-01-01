
class Api::FormattedDataController < ApplicationController
    require 'yaml'
  
    def index
      input_data = [
            { name: 'Maria Neusa de Aparecida',  cpf: '97905796671',  state: 'Sao Paulo',  value: '1234' },
            { name: 'Ricardo Fontes',cpf: '44010762900', state: 'Rio Grande do Sul', value: '567' }
          ]
          
  
      format_config = load_format_config
      formatted_data = solucao_formatar(input_data, format_config)
      render json: { result: formatted_data }
    end
  
    private

  def solucao_formatar(arg, format_config)
    result = ""

    arg.each do |person|
      line = ""

      format_config.keys.each do |key|
        field_config = format_config[key]
        value = person[key.to_sym].to_s
        length = field_config['length']
        align = field_config['align']
        padding = field_config['padding']

        value = value[0, length] if value.length > length

        formatted_value = align == 'right' ? value.rjust(length, padding == 'zeroes' ? '0' : ' ') : value.ljust(length, padding == 'zeroes' ? '0' : ' ')

        line += formatted_value
      end

      result += "#{line}\n" 
    end

    result
  end
      
  
    def load_format_config
      YAML.load_file('config/format.yaml')
    end
  end
  