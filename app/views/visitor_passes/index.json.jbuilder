json.array!(@visitor_passes) do |visitor_pass|
  json.extract! visitor_pass, :id, :visitor_phone_number, :active, :used
  json.url visitor_pass_url(visitor_pass, format: :json)
end
