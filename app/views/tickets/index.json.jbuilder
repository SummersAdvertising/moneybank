json.array!(@tickets) do |ticket|
  json.extract! ticket, :name, :gender, :phone, :email, :quota, :status
  json.url ticket_url(ticket, format: :json)
end
