json.array!(@reports) do |report|
  json.extract! report, :id, :title, :content, :source, :user_id, :author, :viewed, :approved, :sent, :published
  json.url report_url(report, format: :json)
end
