# Expense Claim Application — PRD

## Problem Statement

Employees pay for business expenses out of pocket and today have no consistent
way to submit receipts and get reimbursed — claims travel by email or paper,
approvals are hard to track, and neither the employee nor their manager has a
clear view of what has been submitted, approved, or is still pending.

## Solution

A web application where employees submit expense claims with photos of their
receipts, have the key details (amount, date, vendor, category) automatically
read off the receipt so they don't have to type them in, and track each
claim's status as it moves through their manager's approval. Managers get a
queue of their team's claims to review, approve, or reject with a comment.

## Actors

- **Employee** — submits expense claims with receipts, reviews auto-extracted
details before submitting, tracks and edits/withdraws their own pending
claims, and sees their claim history.
- **Manager** — reviews expense claims submitted by their direct reports,
approves or rejects each with a comment.

## User Stories

1. As an Employee, I want to submit an expense claim with one or more receipt
photos, so that I can request reimbursement for a business expense.
2. As an Employee, I want the amount, date, vendor and category to be
automatically read off my receipt photo, so that I don't have to type them
in myself.
3. As an Employee, I want to review and correct the auto-extracted details
before I submit, so that my claim is accurate.
4. As an Employee, I want to view the status of each claim I've submitted, so
that I know whether it's pending, approved, or rejected.
5. As an Employee, I want to edit or withdraw a claim while it is still
pending, so that I can fix a mistake or cancel it before it's reviewed.
6. As an Employee, I want to see a history of all my past claims, so that I
can track my own spending over time.
7. As a Manager, I want to see a queue of expense claims submitted by my
direct reports, so that I know what's waiting on my review.
8. As a Manager, I want to approve or reject a claim with a comment, so that
the employee understands the decision.
9. As a Manager, I want to set a weekly spending limit for my team by
describing it in plain language, so that I don't have to learn a form to
communicate a budget.
10. As an Employee, I want to see my team's current weekly spending limit
when I'm submitting a claim, so that I know whether I'm about to go over
budget.
11. As an Employee, I want to see when a claim I've submitted breaks the
meals spending policy, with a plain-language reason, so that I understand
why it's flagged.
12. As a Manager, I want to see when a direct report's claim breaks the
meals spending policy, with a plain-language reason, so that I can factor
it into my review.

## Product Decisions

- Sign-in: every user signs in via SSO through Thunder, the platform IDP (org
default).
- Receipt storage: receipt photos are stored directly in the application's
own database, alongside the claim — no external object storage service is
used.
- Receipt data extraction: an agent reads each uploaded receipt photo and
pre-fills amount, date, vendor and category on the claim; the employee
reviews and corrects the result before submitting.
- Approval workflow: single-tier approval — a claim goes directly to the
employee's manager, who approves or rejects it. There is no second
(e.g. Finance) approval tier.
- Reimbursement: the app tracks a claim through to "approved" status only.
Actual payout happens outside the app (e.g. via payroll); the app does not
integrate a payments capability.
- Currency: claims are recorded in a single, organization-wide currency
(LKR).
- Expense categories: claims are categorized from a fixed set (Travel, Meals,
Accommodation, Office Supplies, Other).
- Claim editing: an employee may edit or withdraw a claim only while it is
still pending; once approved or rejected it is locked.
- Manager visibility: a manager sees only claims submitted by their own
direct reports, not the whole organization.
- Weekly spending limit: a manager expresses one overall weekly limit for
their whole team in natural language (e.g. "cap spending at 500 LKR a
week"), parsed by an agent into a stored number. It applies team-wide (not
per employee, not per category). It is informational only — an employee sees
the limit when submitting a claim, but going over it does not block
submission.
- Meals spending policy: a fixed, system-wide policy caps Meals-category
spending at 5,000 LKR per calendar day, checked cumulatively across all of
an employee's Meals claims dated that day. A claim that breaks it is flagged
with a plain-language reason, visible to both the employee (on the claim)
and the manager (in the approval queue and claim detail). The policy is
built in, not manager-configurable, and — like the weekly limit — it is
informational only: a flagged claim can still be submitted and reviewed
normally.

## Out of Scope

- Processing or automating the actual reimbursement payment/payout.
- A second (Finance/Admin) approval tier or any policy-compliance check step.
- Multi-currency support or currency conversion.
- Automated policy enforcement — blocking or restricting a submission for
exceeding the weekly limit, the daily meals cap, or any other budget cap. An
over-limit or policy-breaking claim is flagged with a reason but can still
be submitted and reviewed normally.
- Any policy check beyond the daily Meals cap — no alcohol restriction, no
per-category limits beyond Meals, no manager-configurable policy rules.
- Integration with payroll or accounting systems.
- Notifying employees or managers of claim status changes, by any channel
(email, SMS, or in-app) — everyone checks claim status by visiting the app
themselves.

## Open Questions

*(none — all decisions were either settled by organization default or
assumed and flagged above)*