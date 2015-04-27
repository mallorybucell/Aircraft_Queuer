# Aircraft Queue Controller

This app is bare-bones, basic aircraft queue controller, which can enqueue and dequeue aircraft based on the following specifications:

* Queuing system can be accessed via user login

* Enqueued aircraft must specify size and type

* Passenger AC’s have removal precedence over Cargo AC’s

* Large AC’s of a given type have removal precedence over Small AC’s of the same type.

* Earlier enqueued AC’s of a given type and size have precedence over later enqueued AC’s of the same type and size.

# How to Use
  Either clone the repo and spin up a local rails server OR

  Navigate to [[heroku deployment in progress]]
  and login with the following credentials (or create your own):
    * email: User1@example.com
    * password: "password"

# Assumptions/Decisions:

* User login can be used in place of actually spinning-up rails app via command, since this is an isolated instance of a stand-alone subsystem.

* Aircraft should be persistent because:
  - multiple traffic controllers may be spinning it up simultaneously and need access to current information
  - status of system should not be lost in case of power loss, etc.

* In context of the larger application system, available planes may be pulled from broader, pre-existing set. If this were the case, a setup with a "status" attribute or model for existing planes might be a better fit. However, since this was meant to be stand-alone and due to time-constraints, I used functionality for simply creating / deleting planes from the app for enqueing / dequeing respectively.

# Further work:

Given more time, I would implement the following:

### Extract out the dequeing logic from Aircraft into its own DequeueAircraft PORO
  * The current logic seems maybe a bit more than the Aircraft itself needs to know
  * It feels cluttered in the Aircraft model and could be a problem if the app becomes bigger or has more responsibilities

### Add Feature tests Using Capybara for Views/UI
  * Refactor remove countlogic from views

### Better UI, including but not limited to:
* Add ajax/javascript to views so that users would not need to leave the dashboard to add or dequeue planes
* Add pagination for table showing planes currently existing in the system

### Better flash messages
* Replace 'catch-all' error message with more specific error messages.
* Update flash messages and logic to explain which type/size of Aircraft was added/removed, etc.

### Link Aircraft Enqueue/Dequeue to User
* Rework data-model to allow for tracking of which user enequeued or de-queued a specific aircraft