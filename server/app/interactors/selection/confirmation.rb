module Selection
  # USES: user, recipe, event_date, was_made
  #
  # MODIFIES: nothing
  class Confirmation
    include Interactor

    MODIFIES = %i()

    def call
      # Given this event date, find the selected relationship at that date/time, with a tolerance of
      # 3s

      # TODO Raise errors if u, rec, or event_date or undefined

      u = context.user
      rec = context.recipe
      event_date = context.event_date.to_i

      rel = u.query_as(:u)
        .match('u-[r:SELECTED]->(rec:Recipe)')
        .where('abs(r.event_date - {an_event_date}) <= 3')
        .where('ID(rec) = {ID_rec}')
        .params(
          an_event_date: event_date,
          ID_rec: rec.neo_id
        )
        .pluck(:r)
        .first

      if rel
        rel.was_made = context.was_made ? 'y' : 'n'
        rel.date_confirmed = Time.current

        rel.save
      else
        context.fail!(error: 'Could not find a SELECTED relationship between that user and recipe at that time.')
      end
    end
  end
end
