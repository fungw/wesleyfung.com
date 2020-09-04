#!/bin/bash
set -x

gatsby build

# Configure Git to only push the current branch
git config --global push.default simple

# Remove .gitignore and replace with the production version
rm -f .gitignore
cp scripts/prodignore .gitignore
cat .gitignore

# Add the DigitalOcean production server as a remote repository
git remote add production ssh://fungw@165.22.115.151:/home/fungw/gatsbybare.git

# Add and commit all the static files generated by the Gatsby build
git add . && git commit -m "Gatsby build"

# Push all changes to the Linode production server
git push -f production HEAD:refs/heads/master