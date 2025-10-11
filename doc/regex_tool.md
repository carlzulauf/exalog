# Regex Tool

Inspired by rubular. It should be a regular expression playground with a focus on grepping lines.

## Quadrant UI

Considering a UI divided into 4 areas:

* Regular Expression Input
* Data Input
* Result List
* Match Data

The result list might not make sense if we're not in a line matching mode. Maybe in that case the match data pane grows to take its place.

Actually, I think it still makes sense in both modes. We'll highlight matches in either case.

### Regular Expression Input

Something like a text area for inputting simple or complex regular expressions.

* Syntax highlighting
* Multi-line regex support
* Checkboxes/multi-select for available flags
* Toggle between first match and all matches
* Maybe a way to switch from `//` to `%r{}`

### Data Input

The data we're going to match against. Toggles between a text area and an upload.

* Toggle to switch between matching lines and matching entire input
  * In line matching mode, line numbers should be displayed
* Toggle to switch between text area and upload
  * Upload starts with upload form and is replaced with preview of file contents if upload was successful
  * Text area is with/without line numbers depending on line mode

### Result List

Shows highlighted matches/lines.

* In line mode
  * Contains list of matching lines and their line numbers, which matching portion highlighted
  * Each matching line is selectable and shows the match data for the selection in the match data pane
* In string mode
  * Contains the highlighted matching portions with some surrounding context

### Match data

Shows the match data for each match, or the first match if matching entire string.

* Basically displays all data available in ruby's `MatchData` object
  * 
