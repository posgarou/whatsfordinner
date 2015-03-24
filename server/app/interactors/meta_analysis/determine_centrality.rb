module MetaAnalysis
  # Given a +node+, returns the centrality (without taking labels or types of incoming into account).
  #
  # REQUIRES: node
  #
  # MODIFIES: centrality
  #
  # TODO Move this information over to models in terms of before/after callbacks. Though seems error-prone.
  class DetermineCentrality
    include Interactor
    include InteractorParameters

    MODIFIES = %i(centrality)

    def call
      node = context.node
      ensure_presence_of :node

      context.centrality =
        node
          .query_as(:start)
          .match('start<--(node)')
          .return('count(node)')
          .first.values.first
    end
  end
end
