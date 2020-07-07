if exists('b:current_syntax')
  finish
endif
unlet! b:current_syntax

syn region scheduleTask    start='^' end='$'  contains=scheduleHyphen,scheduleYear,scheduleMonth,scheduleDay,scheduleWeekday,scheduleLabel keepend
syn region scheduleComment start='^#' end='$' contains=@Spell

syn match scheduleYear    contained "\<\([0-9]\{4}\)\>"
syn match scheduleHyphen  contained '-'
syn keyword scheduleMonth contained Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
syn match scheduleDay     contained "\<\(-\|[0-9]\{1,2}\)\>"
syn match scheduleWeekday contained "\<\(Sun\|Mon\|Tue\|Wed\|Thu\|Fri\|Sat\)\>\(=[0-9]\)\="
syn region scheduleLabel  contained start="," end="$" contains=scheduleTime,@Spell oneline
syn match scheduleTime    contained "\([0-9]\{2}:[0-9]\{2}-\=\)"

hi def link scheduleComment     Comment
hi def link scheduleHyphen      Operator
hi def link scheduleYear        Operator
hi def link scheduleMonth       Operator
hi def link scheduleDay         Operator
hi def link scheduleWeekday     Operator
hi def link scheduleTime        Function
hi def link scheduleLabel       String

let b:current_syntax = 'schedule'
