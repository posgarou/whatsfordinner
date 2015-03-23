# Speed up response parsing
module ResponseHelpers
  def expect_success
    expect(response.status).to eq(200).or eq(201)
  end

  def expect_400
    expect(response.status).to eq(400)
  end

  def expect_401
    expect(response.status).to eq(401)
  end

  def expect_not_found
    expect(response.status).to eq(404)
  end

  def parse_response
    JSON.parse(response.body)
  end
end
