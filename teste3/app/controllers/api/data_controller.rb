class Api::DataController < ApplicationController
    def index
      people = Person.all
      render json: { result: solucao(people) }
    end
  
    private
  
    def solucao(people)
      result = ""
  
      people.each do |person|
        name = person.name[0, 11].ljust(11)
        cpf = person.cpf[0, 11].ljust(11)
        state = person.state[0, 11].ljust(11)
        value = person.value[0, 11].ljust(11)
  
        result += "#{name}#{cpf}#{state}#{value}\n"
      end
  
      result
    end
  end
  