Twitterer is an iOS application that tracks the tweets streamed
through Twitter matching the keyword "sweden".

A library called "Swifter" was chosen to handle the networking
and authentication for the Twitter platform, to simplify the
implementations details of OAuth2 and networking.
No other library was used.

Once the application is loaded, the service connects to Twitter
and waits for tweets that match the keyword and are displayed
on a table from most recent to oldest, 5 tweets at a time.

The table that displays the tweets uses a queue that handles
the currently displayed items, and a buffer to hold on to newly
arrived tweets. This was done for a better user experience for
the case that several tweets arrived simultaneously would push
the items down, preventing the user from reading them.

Two types of queues were implemented; a simple FIFO queue and a
fixed size FIFO queue (Or ring buffer). Both of the implementations
can be improved if needed (Especially the fixed size FIFO queue,
with a read and write pointers to minimize the array copying).

The application is testable and was implemented with nibs instead
of a storyboard for better reusability and easier testability. 

Some notes about the tests:
- Contains both tests and UI tests
- The Twitter service is mocked to be and injectable on the view
  controller to be able to test it. Some code in the app code
  is required, due to limitations of UITest functioning as a
  black box.
- The Fixed size FIFO queue has basic test
