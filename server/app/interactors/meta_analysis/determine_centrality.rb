module MetaAnalysis
  # Given a +node+, returns the centrality (without taking labels or types of incoming into account).
  #
  # REQUIRES: node
  #
  # MODIFIES: centrality
  class DetermineCentrality
    include Interactor

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

    def ensure_presence_of *args
      args.each do |arg|
        context.fail!(error: "#{arg.to_s.titleize} is required") unless context.send(arg).present?
      end
    end
  end
end
