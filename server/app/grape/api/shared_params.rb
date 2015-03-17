module API
  module SharedParams
    extend Grape::API::Helpers

    params :pagination do
      optional :p, type: Integer, default: 1, desc: 'Current page of paginated recipes. Defaults to 1.'
      optional :per_page, type: Integer, default: 20, values: 1..40, desc: 'Number to include per request. '
    end
  end
end
