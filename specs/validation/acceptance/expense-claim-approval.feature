Feature: Manager approval of expense claims

  @story-7
  Rule: A manager sees a queue of expense claims submitted only by their own direct reports

    Scenario: The approval queue lists direct reports' claims
      Given Priya the manager has a direct report Dana who submitted a pending claim for "Riverside Bistro"
      When Priya opens her approval queue
      Then she sees Dana's pending claim for "Riverside Bistro" in the queue

    @negative
    Scenario: A manager does not see claims outside their own team
      Given Sam is not one of Priya the manager's direct reports and has submitted a pending claim for "Acme Airlines"
      When Priya opens her approval queue
      Then Sam's claim for "Acme Airlines" does not appear in it

  @story-8
  Rule: A manager can approve or reject a submitted claim with a comment

    Scenario: Approving a submitted claim
      Given Priya the manager has a direct report Dana with a pending claim for "Riverside Bistro"
      When Priya approves that claim with the comment "Looks good"
      Then the claim shows status "approved" with the comment "Looks good"

    Scenario: Rejecting a submitted claim
      Given Priya the manager has a direct report Dana with a pending claim for "Acme Airlines"
      When Priya rejects that claim with the comment "Missing itemized receipt"
      Then the claim shows status "rejected" with the comment "Missing itemized receipt"

    @negative
    Scenario: An already-decided claim cannot be decided again
      Given Priya the manager has a direct report Dana whose claim for "Riverside Bistro" was already approved
      When Priya tries to reject that same claim
      Then the claim still shows status "approved"
