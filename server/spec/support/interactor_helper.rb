shared_examples_for 'a well-behaved interactor' do |interactor_subject|
  it 'only modifies the declared fields' do
    # Evaluate the interactor passed in
    interactor = interactor_subject.is_a?(Symbol) ? (send interactor_subject) : interactor_subject

    # Original context
    # Intentionally not a deep clone.
    original_context = interactor.context.clone

    # Get the context after run
    interactor.run
    modified_context = interactor.context

    # Class for constant lookup
    interactor_class = interactor.class

    # As long as MODIFIES is not declared as an empty array, we should expect the
    # starting and ending contexts not to be equal.
    unless interactor_class::MODIFIES.empty?
      expect(original_context).not_to eq(modified_context)
    end

    # Remove each declared MODIFIES field from both beginning and ending context
    [original_context, modified_context].each do |context|
      interactor_class::MODIFIES.each do |field|
        # Nil checks wouldn't work, because we don't want to (necessarily) remove nil fields
        context.delete_field field rescue NameError
      end
    end

    # After removing the modified field(s), the contexts should be equal
    expect(original_context).to eq(modified_context)
  end
end
