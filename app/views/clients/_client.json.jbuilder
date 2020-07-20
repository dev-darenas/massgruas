json.extract! client, :id, :nombre, :identificacion, :razon_social, :regimen, :actividad_comercial,
                                  :direccion, :ciudad, :telefono, :email, :created_at, :updated_at
json.accounts do
  json.array! @client.accounts
end
json.url client_url(client, format: :json)
