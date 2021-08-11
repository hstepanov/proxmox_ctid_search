#!/bin/bash
##########################################################
#       Script get an ip address of some container       #
#      and trying to find this ip in each container.     #
# If search was successfull, script tell the container_id#
##########################################################
#
# Let's declare some function
search_ct() {
    for CTID in $( pct list | awk '{print $1}' )
        do
            if [[ $CTID == "VMID" ]]
    	        then continue
    	    else pct exec $CTID ip a | grep $CT_IP 1>/dev/null
    	        if [[ $? -ne 0 ]]
    	            then continue
    		else
                        echo "********** THIS IS WIN BRO! ***********" 
                        echo "Looks like we search for $CTID container!"
                        echo "***************************************"
                        exit 0
    		fi
            fi
    done
}

echo -n "Input container ip, son: "
read CT_IP

# Try to check if IP doesn't contain any nondigit symbols
# If it so then we call search_ct func
if [[ $CT_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
    then
        search_ct
    elif [[ $CT_IP == "" ]]
    then
        echo "*** You should input one valid ip address. See you! ***"
	exit 1
    else
        echo "*** Ha-ha! Nice try boy, but you ought to input valid ip address! ***";
        exit 1
fi
