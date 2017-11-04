# Programming Best Practices

## Start-up phase
* Always discuss purpose and general strategy before starting a project.
* Always make wireframes.
* If you know you're going to need some big complex tech (like a new JS library or a complex-to-use gem), study it independently first.
* Set up Guard and always keep it running.

## Development phase
* The main purpose of these rules is to secure *maintainability.* Just getting the code done is half (or 3/4?) of the job. Getting it fully tested, refactored, documented, and remembered in your head is what will make it possible to develop more later.
* To the greatest extent feasible, practice TDD. The most obvious tests will suggest themselves, but when you get to a stopping place (e.g., when you're going to do a push), add less obvious tests as well.
* Develop controllers, test data, and tests before designing views.
* Document everything, but generally wait until refactoring to do this in great detail (since the details change):
  * Always put one or two lines (at least) before every method, explaining what it does.
  * Take special care to note anything unusual.
  * If you forget to do this, go back afterward and add it in.
  * Don't forget to document HTML and CSS.
  * CSS in particular needs documentation because the purposes of the little details are *usually* unclear at a glance. 
* Make SuperMemo questions about any new methods, commands, tools, concepts, etc. you learn *as you develop* (not afterward; but if you must, then go ahead do it afterward).
* Refactor regularly (e.g., after each major push):
  * Review methods; make sure they can't be done more elegantly.
  * DRY up your code; add helper methods.
  * Don't forget to review test code. It needn't be perfect but it can be usefully cleaned up.
  * Add and refactor documentation, which can get old and positively misleading. Check for good documentation throughout.
