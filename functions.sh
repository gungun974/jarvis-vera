#!/bin/bash
# Here you can create functions which will be available from the commands file
# You can also use here user variables defined in your config file
# To avoid conflicts, name your function like this
# pg_XX_myfunction () { }
# pg for PluGin
# XX is a short code for your plugin, ex: ww for Weather Wunderground
# You can use translations provided in the language folders functions.sh

pg_vc_turn () {
    # $1: action [on|off]
    # $2: received order
    if [[ true ]]; then
        say "$(pg_vc_lang "switching_$1" "$2")"
        if [[ $1 == "on" ]]; then
        	jv_curl "http://$pg_vc_vera_ip:3480/data_request?id=action&output_format=json&serviceId=urn:upnp-org:serviceId:SwitchPower1&action=SetTarget&newTargetValue=1&DeviceNum=40"
        else
        	jv_curl "http://$pg_vc_vera_ip:3480/data_request?id=action&output_format=json&serviceId=urn:upnp-org:serviceId:SwitchPower1&action=SetTarget&newTargetValue=0&DeviceNum=40"
        fi
        return $?
    fi
    say "$(pg_vc_lg "no_device_matching" "$2")"
    return 0 # error already said above, no need to trigger error phrase
}