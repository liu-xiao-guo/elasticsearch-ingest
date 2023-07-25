#!/bin/bash

source ./.env

hostprotocol="http"
if [ "$ELASTICSSL" = "true" ]; then
  hostprotocol="https"
fi

curl -k -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/order"
curl -k -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_ingest/pipeline/order_pipeline"

curl -k -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/order_item"
curl -k -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/order_item_policy"
curl -k -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_ingest/pipeline/order_item_pipeline"

curl -k -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/product"
curl -k -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/product_policy"

curl -k -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/customer"
curl -k -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/customer_policy"
curl -k -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_ingest/pipeline/customer_pipeline"

curl -k -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/zip_geo"
curl -k -X DELETE -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_enrich/policy/zip_geo_policy"


