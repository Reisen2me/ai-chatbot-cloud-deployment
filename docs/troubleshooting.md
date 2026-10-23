# Troubleshooting notes

These are case-study observations from an actual personal deployment. They are not upstream bug reports or claims that the underlying software is defective.

## NapCat restart and QQ session

**Question investigated:** Does restarting the `napcat` service require scanning a QQ login QR code again?

**Investigation:** Viewed `systemctl status napcat`, restarted the service and checked logs. A previously observed deployment had an active service with a process tree including `xvfb-run` and the QQ executable. Login/session persistence depends on the upstream implementation and how its state is stored.

**Learning:** Distinguish a healthy Linux service from a usable application session. A running process does not, by itself, prove a QQ account is authenticated. No verified long-term persistence result is claimed here.

## Model provider quota

**Symptom explored:** Gemini API configuration produced a quota-related failure.

**Approach:** Reviewed the provider configuration and distinguished provider quota failures from local networking or chatbot-process failures.

**Learning:** API key acceptance does not guarantee remaining provider capacity. Apply appropriate usage limits and consult provider-side dashboards and policies.

## Free model latency and provider choice

**Symptom explored:** A free forwarded LLM endpoint responded slowly despite being reachable.

**Approach:** Used a local `curl` request to an OpenAI-compatible `/v1/chat/completions` endpoint and compared the practical experience of alternative API arrangements.

**Learning:** End-to-end time includes queueing, upstream provider latency and networking, not just cloud-region proximity. Do not claim quantitative speed comparisons without repeatable measurements.

## Direct endpoint test

A local test used a loopback endpoint and a bearer token read from a private settings file. This repository replaces that with a safer pattern: supply an environment variable interactively and never store a real key in Git. See `scripts/llm-api-smoke-test.sh`.

## Future improvement ideas (not implemented)

- independent health monitoring with alerting
- safely tested automatic fallback between model providers
- automated deployment and config validation
- CI checks for shell scripts
