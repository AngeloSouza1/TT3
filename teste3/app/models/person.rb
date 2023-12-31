class Person < ApplicationRecord
    validates_presence_of :name, :cpf, :state, :value
end
