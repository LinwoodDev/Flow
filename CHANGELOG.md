# Changelog

<!--ENTER CHANGELOG HERE-->

## 0.4.2 (2025-04-28)

* Add linking to users and groups tab view
* Add import and exporting settings
* Add more density options to settings
* Reworking paging system to a built in solution
* Fix user page alignment
* Fix safe area of navigation drawer
* Fix ical importer doesn't import calendar items ([#89](https://github.com/LinwoodDev/Flow/issues/89))
* Fix event user connecting not working correctly
* Fix dismissing removes items instead of disconnecting them
* Fix butterfly is referenced instead of flow
* Fix linux appdata

Read more here: https://linwood.dev/flow/0.4.2

## 0.4.1 (2025-04-07)

* Unify settings dialog with other linwood apps
* Improve dashboard design
* Use linking instead of creating inside details tab views
* Fix calendar fetching not working correctly ([#86](https://github.com/LinwoodDev/Flow/issues/86))
* Fix group list view not working correctly
* Fix user list view not working correctly
* Fix note list view not working correctly

Read more here: https://linwood.dev/flow/0.4.1

## 0.4.0 (2025-03-24)

* Add color wheel
* Add event notes
* Add owner for notes, labels and notebooks
* Change events and calendar items to have multiple users and groups
* Change users to have multiple groups
* Refactor places to resources
  * Allow many-to-many relationship
  * Add owner for resources
* Fix color picker not using current color
  * Rename places to resources and allow for multiple resources
  * Add resources to events
* Fix docker file
* Users can now be added to events and calendar items
* Convert data classes to dart_mappable
* Upgrade to flutter 3.29
* Use minSdkVersion 23 instead of 21 (The minimum version of android is 6.0 (Marshmallow))
* Fix labels not filtering correctly
* Update to agb 8.9
* Update theme

Read more here: https://linwood.dev/flow/0.4.0

## 0.3.1 (2024-11-18)

* Add right click menus
* Add new icons ([#22](https://github.com/LinwoodDev/Flow/issues/22))
* Update app color to match the new icons
* Make icon bigger
* Fix month view start of the week
* Upgrade project layout
* Upgrade to flutter 3.24

Read more here: https://linwood.dev/flow/0.3.1

## 0.3.0 (2024-05-27)

* Add clock to dashboard
* Add density setting
* Add high contrast mode
* Add classic theme
* Add notebooks
* Allow changing group and place in event creation dialog
* Make dashboard the back page
* Improve icon style for different calendar item types
* Improve custom title bar window buttons
* Improve material 3 colors of chips
* Improve child notes layout
* Improve dialogs to go full screen on mobile
* Use default page transition instead of fade
* Unify select dialogs
* Fix locale translations
* Fix week system in calendar week view
* Fix switching from moment to appointment doesn't update the dialog
* Fix list view has duplicated items
* Upgrade to flutter 3.19 and 3.22

Read more here: https://linwood.dev/flow/0.3

## 0.2.1 (2023-11-10)

* Add macos and rpm builds
* Make calendar views switcher smaller
* Simplify notes view
* Allow editing in date time field
* Disable PrivilegesRequired in windows setup ([#23](https://github.com/LinwoodDev/Flow/issues/23))
* Upgrade dropdowns to material 3
* Fix notes dashboard links
* Fix showing wrong month in month view ([#28](https://github.com/LinwoodDev/Flow/issues/28))
* Fix portable build
  * Fix file name in start.sh
  * Add executable permission on linux
  * Fix start.sh
* Upgrade to flutter 3.16
* Upgrade to agb 8

View all changes in the blog: https://linwood.dev/flow/0.2

## 0.2.0 (2023-07-28)

* Add virtual window frame
* Add links to dashboard
* Add ical remote storage
* Add weekdays in list view
* Add setting to set start of week
* Add large layout for calendar
* Use phosphor icons
* Improve title bar
* Fix dashboard scrolling and spacing issues
* Fix primary card in notes
* Fix end drawer
* Fix collideswith
* Fix month view
* Fix ical importer for start date time
* Fix internet permission on android
* Upgrade to flutter 3.10

View all changes in the blog: https://linwood.dev/flow/0.2

## 0.1.3 (2023-05-01)

* Add weekday to week view
* Improve date colors in month view
* Fix dialog results
* Fix markdown in lists
* Fix calendar week display
* Fix week view not starting on Monday

## 0.1.2 (2023-04-29)

* Add version to settings
* Add place to event filter
* Improve list views
* Fix windows setup again
* Fix missing translation

## 0.1.1 (2023-04-27)

* Fixing database directory

## 0.1.0 (2023-04-27)

First release 🎉
