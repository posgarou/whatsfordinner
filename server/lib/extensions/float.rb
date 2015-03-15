class Float
  # E.g., 2.5 => 2.5 and 1.0 => 1
  #
  # From the venerable Yehuda Katz: http://stackoverflow.com/a/1077648
  def prettify
    to_i == self ? to_i : self
  end
end
