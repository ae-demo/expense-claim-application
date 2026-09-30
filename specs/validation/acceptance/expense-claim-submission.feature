Feature: Submitting and tracking expense claims

  @story-1
  Rule: An employee can submit an expense claim with one or more receipt photos

    Scenario: Submitting a claim with a receipt
      Given Dana the employee has a receipt photo from "Riverside Bistro" for "42.50"
      When Dana submits an expense claim with that receipt photo
      Then the claim appears in Dana's claims with status "pending"

  @story-2
  Rule: The amount, date, vendor and category are automatically read off the uploaded receipt photo

    Scenario: Auto-extracted fields appear before submission
      Given Dana the employee has uploaded a receipt photo from "Riverside Bistro" for "42.50" dated "2026-09-12"
      When Dana reaches the claim review step
      Then the amount, date, vendor and category fields are already filled in from the receipt

  @story-3
  Rule: An employee can review and correct the auto-extracted details before submitting

    Scenario: Correcting a misread amount before submitting
      Given the auto-extracted amount for Dana's receipt from "Riverside Bistro" reads "42.00"
      When Dana corrects the amount to "42.50" and submits the claim
      Then the claim is recorded with an amount of "42.50"

  @story-4
  Rule: An employee can view the status of each claim they have submitted

    Scenario: Checking a claim's status
      Given Dana the employee has a submitted claim for "Riverside Bistro"
      When Dana opens her list of claims
      Then she sees that claim's current status

  @story-5
  Rule: An employee may edit or withdraw a claim only while it is still pending

    Scenario: Editing a pending claim
      Given Dana the employee has a pending claim for "Riverside Bistro" with amount "42.50"
      When Dana edits that claim's amount to "45.00"
      Then the claim shows an amount of "45.00"

    Scenario: Withdrawing a pending claim
      Given Dana the employee has a pending claim for "Riverside Bistro"
      When Dana withdraws that claim
      Then that claim no longer appears in Dana's active claims

    @negative
    Scenario: An approved claim cannot be edited
      Given Dana the employee has a claim for "Riverside Bistro" that has already been approved
      When Dana tries to edit that claim's amount
      Then the claim's amount is unchanged

    @negative
    Scenario: A rejected claim cannot be withdrawn
      Given Dana the employee has a claim for "Riverside Bistro" that has already been rejected
      When Dana tries to withdraw that claim
      Then the claim still appears in Dana's claims with status "rejected"

  @story-6
  Rule: An employee can see a history of all their past claims

    Scenario: Viewing claim history across statuses
      Given Dana the employee has a pending claim for "Riverside Bistro", an approved claim for "Office Depot", and a rejected claim for "Acme Airlines"
      When Dana opens her claim history
      Then she sees all three claims listed with their respective statuses
