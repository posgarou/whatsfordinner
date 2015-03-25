class Similarity::GatherComparisonData
  include Interactor::Organizer

  organize Similarity::CompareCuisines,
    Similarity::CompareIngredients,
    Similarity::CompareIngredientGroups,
    Similarity::CompareTags,
    Similarity::CompareUserRatings
end
