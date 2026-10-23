# Architecture

An Ubuntu virtual machine hosted on Oracle Cloud runs third-party chatbot components:

1. NapCat provides the QQ messaging interface.
2. AstrBot handles chatbot workflows and requests to an LLM provider.
3. The configured LLM endpoint generates a reply.
4. The response is returned through the messaging gateway.

The services are managed locally on the VM. This repository deliberately excludes upstream source code and sensitive production configuration.
