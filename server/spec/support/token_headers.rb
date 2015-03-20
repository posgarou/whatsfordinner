module TokenHeaders
  def valid_headers graph_user, client: nil, expiry: nil
    user = graph_user.standard_user
    client ||= 'wfdinner_app'
    token = user.most_recent_token(client)

    {
      "Token-Type" => "Bearer",
      "Client" => client,
      "Expiry" => token.expiry,
      "Uid" => token.uid,
      "Access-Token" => token.value
    }
  end
end
