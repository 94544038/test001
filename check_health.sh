#!/bin/bash
#cat check_health.sh

LOG=$HOME/log/check_health.log
times=$(date "+%Y-%m-%d %H:%M:%S")
OC_BUSINESS_TYPE_GROUP=(
"OC"
"OC-SMS"
"OC-PS"
"OC-IN"
"OC-IMS"
)

RETCODE="Not OK"
if [ "$BUSINESS_TYPE" = "RULEC" ]; then
    if [ -f "$HOME/rc.result" ]; then
        result=`cat $HOME/rc.result`
        if [ $result -eq 0 ]; then
            RETCODE="OK"
        fi
    fi
elif [[ "${OC_BUSINESS_TYPE_GROUP[@]}" =~ "$BUSINESS_TYPE" ]];then
    num=`ps -x|awk '{print $5}'|grep -x OCPro|wc -l`
    if [ $num -ge 1 ]; then
        sleep 1
        RETCODE="OK"
    fi
elif [ "$BUSINESS_TYPE" = "CDRG" ]; then
    num=`ps -x|awk '{print $5}'|grep -x CDR|wc -l`
    if [ $num -ge 1 ]; then
        sleep 1
        RETCODE="OK"
    fi
elif [ "$BUSINESS_TYPE" = "SERV" ]; then
    num=`ps -x|awk '{print $5}'|grep -x ZSmartService|wc -l`
    num1=`ps -x|awk '{print $5}'|grep -x ZSmartManager|wc -l`
    if [ $num -ge 1 ] && [ $num1 -ge 1 ]; then
        RETCODE="OK"
    fi
else
    #get fifth row [COMMAND] and match 'ZSmartMonitor' exactly
    num=`ps -x|awk '{print $5}'|grep -x ZSmartMonitor|wc -l`
    if [ $num -ge 1 ]; then
        RETCODE="OK"
    fi
fi
echo "$times:The status of RETCODE is: $RETCODE" >> $LOG
echo $RETCODE