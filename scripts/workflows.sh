#!/bin/sh

# read the workflow template
WORKFLOW_TEMPLATE=$(cat .github/service-template.yml)

# iterate each route in routes directory
for ROUTE in $(ls microservices); do
    echo "generating workflow for microservices/${ROUTE}"

    # replace template route placeholder with route name
    WORKFLOW=$(echo "${WORKFLOW_TEMPLATE}" | sed "s/{{ROUTE}}/${ROUTE}/g")

    # save workflow to .github/workflows/{ROUTE}
    echo "${WORKFLOW}" > .github/workflows/${ROUTE}.yml
done
