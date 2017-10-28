# Create iCal/ics-events by converting a `csv`-file or table

## What it does

This script converts a `csv`-file (or R-dataframe) to an `.ics`-file that can important into calendars, e.g. the default iOS calendar app or Google calendar. 

## How it works

* run `create_events.R`

  * Import an `csv`-file
  * Build an `.ics`-events by iterating over the rows
  * Export an `.ics`-file

## Default `ics`-event

The `ics`-templates follows the example on [Wikipedia](https://en.wikipedia.org/wiki/ICalendar) and uses the following parameters for a single event:

```
BEGIN:VCALENDAR
VERSION:2.0
PRODID:http://www.example.com/calendarapplication/
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VEVENT
DTSTART:20060912T060000
DTEND:20060912T070000
UID:461092315540@example.com
LOCATION:Somewhere
SUMMARY:title of event
DESCRIPTION: description of event
END:VEVENT
END:VCALENDAR
```
Every entry needs an unique ID `UID`.

Multiple events can be created by repeating the section between `BEGIN:VEVENT` and `END:VEVENT`
. For example adding two events with one `.ics`-file (and - important - different `UID`'s):

```
BEGIN:VCALENDAR
VERSION:2.0
PRODID:http://www.example.com/calendarapplication/
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VEVENT
DTSTART:20060912T060000
DTEND:20060912T070000
UID:461092315540@example.com
LOCATION:Somewhere
SUMMARY:title of event
DESCRIPTION: description of event
END:VEVENT
BEGIN:VEVENT
DTSTART:20060912T060000
DTEND:20060912T070000
UID:461092315541@example.com
LOCATION:Somewhere
SUMMARY:title of 2nd event
DESCRIPTION: description of 2nd event
END:VEVENT
END:VCALENDAR
```

More documentation and specifications can be found [here](https://www.kanzaki.com/docs/ical/).

## Example

The example uses data from [a lecture series](https://www.uni-muenchen.de/studium/studienangebot/lehrangebote/ringvorlesung/rv_17_18/index.html).

The `csv`-file needs to look like this:

| starttime       | endtime         | summary                                     | description                                                                                                     | location                                  | 
|-----------------|-----------------|---------------------------------------------|-----------------------------------------------------------------------------------------------------------------|-------------------------------------------| 
| 20171017T191500 | 20171017T204500 | Podiumsdiskussion: Wem gehören meine Daten? | Hörsaal B 101 https://www.uni-muenchen.de/studium/studienangebot/lehrangebote/ringvorlesung/rv_17_18/index.html | Geschwister-Scholl-Platz 1, 81669 München | 
