module Concierge
  module Prefatory
    class GatherLikesAndDislikes
      include Interactor
      include InteractorParameters

      attr_accessor :user

      MODIFIES = %i(query_partial)

      def call
        ensure_presence_of :user
        self.user = context.user

        all_ratings = get_sets_of_ratings

        context.positive = all_ratings[1]
        context.meh = all_ratings[0]
        context.dislike = all_ratings[-1]
      end

      def get_sets_of_ratings
        res = user
          .query_as(:u)
          .match('u-[rated:RATED]->(rec:Recipe)')
          .return('rated.rating AS rating, rec.uuid AS rec')
          .to_a.group_by(&:rating)

        # res is a set of openstructs grouped by rating. parse it down to just the uuid
        res.values.map { |set| set.map!(&:rec) }

        res
      end
    end
  end
end
