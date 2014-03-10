json.array!(@contests) do |contest|
  json.extract! contest, :id, :name, :starts_at, :ends_at, :regulations
  json.url contest_url(contest, format: :json)
end
