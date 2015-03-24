# Ensures that a required parameter is passed
# into the context of an interactor.
module InteractorParameters
  def ensure_presence_of *params
    params.each do |param|
      unless context.send(param).present?
        context.fail!(
          error: "#{param.to_s.titleize} is required"
        )
      end
    end
  end
end
