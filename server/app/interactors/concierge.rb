class Concierge
  include Interactor

  def call
    context.suggestions = (if Graph::Recipe.count < 4
      Graph::Recipe.all
    else
      Graph::Recipe.all.map(&:uuid).sample(3).map { |uuid| Graph::Recipe.find(uuid) }
    end)
  end
end
