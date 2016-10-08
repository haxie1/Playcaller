# Playcaller
Track results of in-game play calling

# Description:

Playcaller is an iOS application that provides a simple method for tracking results of play calls during a football game. It lets you create a playsheet for each opponent, and then track, per series, the result of each play. Just create a team profile, add your plays to the playbook, and then on game day, create a playsheet for and go to work on your next opponent.

# Details:
While the app is intended for real world use, it is mainly a demo app that I am using to workout a Flux like eventing system that leverages the Coordinator pattern for navigation and View Controller management. The project includes the "Events" framework that provides the eventing system and borrows heavliy from Facebook's Flux pattern for unidirectional data flow and management. It departs from that pattern by also using this system for handling navigation through coordinators. The goal is to keep view controllers lean and decoupled, with a simple to understand dataflow and architecture.
---- all of this is very much a work-in-progress ----
