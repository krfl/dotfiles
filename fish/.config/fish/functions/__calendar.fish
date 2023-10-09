# prints events from calendar
# using icalbuddy and excluding a calendar I don't want to see
function __calendar -d 'prints events from the apple calendar using icalbuddy'
    #command icalBuddy -f -sc -ss "" -npn -nc -ps "/ » /" -eed -eep "notes,attendees" eventsToday
    #command icalBuddy -f -npn -nc -ps "/ » /" -eed -eep "notes,attendees" -ec "3094DBB3-993B-4DBA-8BED-87D842567460,3E04FCE2-7845-4B8E-9A63-C1EFC52EAFC0" eventsToday
    #command icalBuddy -f -sc -ss "" -ec "0B859D0F-FDA1-4152-A59E-7AC012E4A433" -eed -eep "notes,attendees" eventsToday
    command icalBuddy -f -ec "0B859D0F-FDA1-4152-A59E-7AC012E4A433,3094DBB3-993B-4DBA-8BED-87D842567460,3E04FCE2-7845-4B8E-9A63-C1EFC52EAFC0" -eed -eep "notes,attendees" eventsToday
end
