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
7. As an Employee, I want to be notified when a claim's status changes, so
that I know the outcome without having to check manually.
8. As a Manager, I want to see a queue of expense claims submitted by my
direct reports, so that I know what's waiting on my review.
9. As a Manager, I want to approve or reject a claim with a comment, so that
the employee understands the decision.
10. As a Manager, I want to be notified when a new claim needs my approval, so
that I can act on it promptly.

## Product Decisions

- Sign-in: every user signs in via SSO through Thunder, the platform IDP (org
default).
- Receipt storage: receipt photos are stored using the organization's
registered object storage capability (`aws-s3`) via presigned upload/view
URLs (org default, given).
- Notifications: status-change and new-claim-for-approval notifications are
sent by the organization's registered transactional email capability
(`email-service`) (org default, given).
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
(USD).
- Expense categories: claims are categorized from a fixed set (Travel, Meals,
Accommodation, Office Supplies, Other).
- Claim editing: an employee may edit or withdraw a claim only while it is
still pending; once approved or rejected it is locked.
- Manager visibility: a manager sees only claims submitted by their own
direct reports, not the whole organization.
- Notification channel: notifications are sent by email only (not SMS).  
*assumed*

## Out of Scope

- Processing or automating the actual reimbursement payment/payout.
- A second (Finance/Admin) approval tier or any policy-compliance check step.
- Multi-currency support or currency conversion.
- Expense policy enforcement (e.g. per-category spending limits, budget
caps).
- Integration with payroll or accounting systems.
- SMS notifications.

## Open Questions

*(none — all decisions were either settled by organization default or
assumed and flagged above)*