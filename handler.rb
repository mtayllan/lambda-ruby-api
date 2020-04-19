# frozen_string_literal: true

load 'vendor/bundle/bundler/setup.rb'

require 'correios-cep'

def handler(event:, context:)
  cep = event['pathParameters']['cep']

  address = Correios::CEP::AddressFinder.get(cep)

  if address.empty?
    { statusCode: 404, body: 'CEP não encontrado' }
  else
    { statusCode: 200, body: JSON.generate(address) }
  end
rescue ArgumentError
  { statusCode: 422, body: 'Formato de CEP inválido' }
end
