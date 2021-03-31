# CRM Modernization - V9

## Application Status

Mainframe access will entirely changed using Kafka Messages and CICS wrapper

## Application Architecture

Domain-Driven architecture, foreach a microservice will be written and connected to back-end using Kafka
https://community.ibm.com/community/user/ibmz-and-linuxone/blogs/mark-cocker1/2020/08/07/cics-and-kafka-integration.
Existing JAVA layer to be removed

## Development Process

Some concerns regarding API Management, need to check which API is used, centralized authentication/autorization must be managed
