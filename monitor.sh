#!/bin/bash -x


# url of the site that that you are monitoring.
slackwebhook=https://
url=http://


# slack messaging function.

slack_msg () {


msg=$1


curl -X POST --data-urlencode "payload={\"channel\": \"#monitoring\", \"username\": \"Jarvis\", \"text\": \"${msg}\", \"icon_emoji\": \":robot_face:\"}" ${slackwebhook}


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
 
