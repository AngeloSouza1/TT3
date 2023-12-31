class Api::DataController < ApplicationController
    def show
      input = [
        { name: 'Maria Neusa de Aparecida', cpf: '97905796671', state: 'Sao Paulo', value: '1234' },
        { name: 'Ricardo Fontes', cpf: '44010762900', state: 'Rio Grande do Sul', value: '567' }
      ]
  
      render json: { result: solucao(input) }
    end
  
    private
  
    def solucao(arg)
      result = ""
  
      arg.each do |item|
        name = item[:name][0, 11].ljust(11)
        cpf = item[:cpf][0, 11].ljust(11)
        state = item[:state][0, 11].ljust(11)
        value = item[:value][0, 11].ljust(11)
  
        result += "#{name}#{cpf}#{state}#{value}\n"
      end
  
      result
    end
  end
  