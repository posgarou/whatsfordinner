# Concept

It's generally accepted to be a good practice to run your tests in random order.  But when you're dealing with complex sets of data.

1. it takes a very long time to generate all of that data for each test (and clean it up after each test), and
2. oftentimes you're interested in transformations that of your data over the life of several methods.

Basically what this is is backend integration.  There's nothing too fancy here.  Adding :backend_integration to a describe block does two things.

1. It sets the order to defined, and
2. It makes it so that database cleaning starts with the entire (outer) describe block and then is run after the whole outer describe block is finished.
