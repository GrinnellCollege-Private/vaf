#!/bin/bash
cd ~/Projects/vaf
docker image build -t vaf-update .
docker login
docker tag vaf-update mcfatem/vaf:latest
docker push mcfatem/vaf:latest
