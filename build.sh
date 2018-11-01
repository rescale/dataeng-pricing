#!/bin/bash

if ! which terraform; then
    echo "No terraform binary found, download and install"
fi

terraform init
terraform apply
