#!/bin/bash
echo "Running $ gulp. This installs front-end dependencies and compiles assets."
echo "The first time you start the server, this may take some time."

cd client && gulp

echo "Gulp finished!"

cd .. && bundle exec rackup