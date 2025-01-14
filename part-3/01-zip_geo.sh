#!/bin/bash

source ./.env

hostprotocol="http"
if [ "$ELASTICSSL" = "true" ]; then
  hostprotocol="https"
fi

curl -k -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/zip_geo"
curl -k -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/zip_geo/_mapping" \
-H "Content-Type: application/json" \
-d @$PROJECTPATH/mapping/zip_geo.json


logstashconf=`cat ${PROJECTPATH}/logstash/zip_geo.conf`
logstashconf="${logstashconf//\#\#PROJECTPATH\#\#/"$PROJECTPATH"}"
logstashconf="${logstashconf//\#\#ELASTICHOST\#\#/"$ELASTICHOST"}"
logstashconf="${logstashconf//\#\#ELASTICSSL\#\#/"$ELASTICSSL"}"
logstashconf="${logstashconf//\#\#ELASTICUSER\#\#/"$ELASTICUSER"}"
logstashconf="${logstashconf//\#\#ELASTICPASS\#\#/"$ELASTICPASS"}"
logstashconf="${logstashconf//\#\#FINGERPRINT\#\#/"$FINGERPRINT"}"
$LOGSTASHPATH/bin/logstash -e "$logstashconf"

curl -k -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/zip_geo_policy" \
-H "Content-Type: application/json" \
-d @$PROJECTPATH/policy/zip_geo.json

sleep 30
curl -k -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/zip_geo_policy/_execute"