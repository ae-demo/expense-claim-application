# Domain Model

The expense claim domain centers on the `ExpenseClaim`, submitted by an
Employee and reviewed by their Manager. Each claim carries one or more
receipts, and a receipt's data may be pre-filled by the extraction agent. A
Manager also sets one `WeeklyLimit` for their team, parsed from natural
language by an agent, which Employees see when submitting a claim. Every
claim is checked against a fixed Meals spending policy (5,000 LKR per
calendar day, cumulative) and flagged with a plain-language reason when it
breaks it.

- `EMPLOYEE.managerId` is the self-relation a Manager's direct-report queue is
scoped by.
- `EXPENSE_CLAIM.status` is one of `pending`, `approved`, `rejected`. A claim
is editable or withdrawable only while `pending`.
- `EXPENSE_CLAIM.currency` is always `LKR` per the Product Decisions.
- `EXPENSE_CLAIM.policyViolated`/`policyReason` are computed when the claim is
submitted: `policyViolated` is true when this claim, combined with the
employee's other Meals claims dated the same day, pushes that day's Meals
total over 5,000 LKR; `policyReason` is the plain-language explanation shown
to both the employee and the manager. Both are null/false for a claim that
does not violate the policy.
- `RECEIPT.extracted` records whether the receipt-extraction agent
successfully pre-filled the claim's fields from this receipt's image.
- `WEEKLY_LIMIT` is one row per manager (their team's current limit), keyed by
`managerId`; setting a new one replaces the amount rather than appending a
history. `currency` is always `LKR`.

