# Frozen source notes: HTTP idempotency

Retrieved: 2026-08-08 UTC

## RFC 9110, section 9.2.2

Source: [https://www.rfc-editor.org/rfc/rfc9110.html#section-9.2.2](https://www.rfc-editor.org/rfc/rfc9110.html#section-9.2.2)

* A method is idempotent when multiple identical requests have the same intended server effect as one request.
* RFC 9110 identifies PUT, DELETE, and safe methods as idempotent. POST is not idempotent by definition.
* Idempotent methods can be retried after a communication failure before the client receives a response because repeating the request is intended to have the same effect.
* A client should not automatically retry a non-idempotent method unless it knows the application semantics are idempotent or can determine that the original request was not applied.

## Stripe API: idempotent requests

Source: [https://docs.stripe.com/api/idempotent_requests](https://docs.stripe.com/api/idempotent_requests)

* A client supplies a unique idempotency key so the server can recognize retries of the same request.
* Stripe compares parameters when a key is reused and reports an error when they differ, which prevents accidental reuse.
* Stripe documents pruning keys after they are at least 24 hours old; reuse after pruning is treated as a new request.
* Results are stored only after endpoint execution begins. Validation failures and conflicts with another concurrently executing request are not stored and can be retried.
* Stripe accepts idempotency keys on POST requests; GET and DELETE are already idempotent by definition in this API guidance.

## Evaluation boundary

The required 409 policy, database unique constraint, request fingerprint, stored processing state and response, TTL choice, and monitoring guidance are scenario requirements supplied by the evaluation prompt. Do not attribute those implementation choices to RFC 9110 or Stripe unless the note above explicitly supports them.
