#!/usr/bin/env fish
# Seed a kando board with realistic demo cards.
# Usage: cd /path/to/project && kando init && fish demo-seed.fish

# -- Backlog --
kando add "Write user authentication docs" -t docs,auth -a maria -p normal
kando add "Add dark mode support" -t ui,feature -p low
kando add "Investigate flaky CI tests" -t ci,bug -a erik -p high
kando add "Migrate database to PostgreSQL 16" -t backend,infra -a jonas,maria -p normal
kando add "Design onboarding flow" -t ux,feature -a lisa -p normal
kando add "Set up error tracking with Sentry" -t infra,observability -p low
kando add "Localize UI for German and French" -t i18n,feature -p low

# -- In Progress --
kando add "Fix login redirect loop" -t auth,bug -a erik -p urgent
kando add "Implement search API endpoint" -t backend,feature -a jonas -p high
kando add "Refactor card component to use slots" -t ui,refactor -a lisa,maria -p normal

# -- Done --
kando add "Set up CI pipeline" -t ci,infra -a jonas -p high
kando add "Create project README" -t docs -a maria -p normal

# Move cards to their columns
kando move 008 in-progress
kando move 009 in-progress
kando move 010 in-progress
kando move 011 done
kando move 012 done

# Set a WIP limit on In Progress
kando config wip in-progress 4

echo "Board seeded with 12 cards."
