



#Freeswitch
### Option: UserParameter
####Channel count
fs_cli -x "show channels count" | grep total | awk {'print $1'}
fs_cli -x "status" | grep 'session(s) - peak' |  awk '{print $8}'

####CPS count
fs_cli -x "status" | grep ' session(s) - peak' | awk '{print $1}'
fs_cli -x "status" | grep 'session(s) per Sec out of max' | awk '{print $13}'


###Sessions count since startup
fs_cli -x "status" | grep "session(s) since startup" | awk {'print $1'}


