module RequestSpecHelper
  # Parse JSON response to Ruby hash
  def json_body
    body = JSON.parse(response.body)
    body.is_a?(Hash) ? body.with_indifferent_access : body
  end
end
