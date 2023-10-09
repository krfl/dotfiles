# prints tasks from reminders
# using icalbuddy
function __reminders -d 'prints reminders from apple reminders using icalbuddy'
    command icalBuddy -f -sc -ss "" -npn -nc -iep "title,datetime" -ps "| : |" -po "datetime,title" -tf "" -df "%RD" -eed tasksDueBefore:today+1
end
