module MetaAnalysis
  # Given a +node+, returns the centrality (without taking labels or types of incoming into account).
  #
  # NB: The return value is a Query object and thus can
  # be further specified before being run.
  #
  # REQUIRES: node
  #
  # MODIFIES: centrality_query
  #
  # TODO Move this information over to models in terms of before/after callbacks. Though seems error-prone.
  class DetermineCentrality
    include Interactor
    include InteractorParameters

    MODIFIES = %i(centrality_query)

    def call
      node = context.node
      ensure_presence_of :node

      context.centrality_query =
        node
          .query_as(:start)
          .match('start<--(node)')
          .return('count(node) AS centrality')
    end
  end
end
