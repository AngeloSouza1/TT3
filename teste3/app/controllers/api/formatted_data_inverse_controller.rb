class Api::FormattedDataInverseController < ApplicationController
  skip_before_action :verify_authenticity_token 
  require 'yaml'

    
    def solucao_inversa
      input_strings = params[:_json]
      format_config = load_format_config
  
      results = input_strings.map do |input_string|
        result = solucao_inversa_method(input_string['input_string'], format_config)
        { result: result }
      end
  
      render json: results
    end
  
    private
  
    def solucao_inversa_method(input_string, format_config)
      result = {}
  
      current_position = 0
      format_config.each do |field, config|
        length = config['length']
        value = input_string[current_position, length].strip
        result[field.to_sym] = value
        current_position += length
      end
  
      result
    end
  
    def load_format_config
      YAML.load_file('config/format_inverso.yaml')
    end
  end
  