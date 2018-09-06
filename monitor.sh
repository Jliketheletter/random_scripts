#!/bin/bash -x


# url of the site that that you are monitoring.

url=http://jaywisniewski.com


# slack messaging function.

slack_msg () {


msg=$1


curl -X POST --data-urlencode "payload={\"channel\": \"#monitoring\", \"username\": \"Jarvis\", \"text\": \"${msg}\", \"icon_emoji\": \":robot_face:\"}" https://hooks.slack.com/services/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


}


# Curl function to pull the status code of the designated site.

get_status () {


   status_code=$(curl -sI ${url} | head -n 1 | awk '{print $2}')
      if [ "${status_code}" == "200" ]
   then 
      slack_msg "Site is working. ${status_code} response code returned"
   else
      slack_msg "Site is returning a ${status_code}. Something is not right."
fi

}

# function call.
get_status 
 
