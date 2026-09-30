Feature: Daily Meals spending policy

  @story-11 @story-12
  Rule: A claim that pushes an employee's same-day Meals total over 5,000 LKR is flagged with a plain-language reason

    Scenario: A single Meals claim over the daily cap is flagged
      Given Dana the employee has no other Meals claims dated "2026-09-12"
      When Dana submits a Meals claim for "5500.00" LKR dated "2026-09-12"
      Then that claim is flagged with a plain-language reason naming the 5,000 LKR daily Meals limit

    Scenario: Two Meals claims on the same day are flagged cumulatively
      Given Dana the employee already has an approved Meals claim of "3000.00" LKR dated "2026-09-12"
      When Dana submits a second Meals claim for "2500.00" LKR dated "2026-09-12"
      Then that second claim is flagged with a plain-language reason naming the 5,000 LKR daily Meals limit

    @negative
    Scenario: A Meals claim within the daily cap is not flagged
      Given Dana the employee has no other Meals claims dated "2026-09-20"
      When Dana submits a Meals claim for "3000.00" LKR dated "2026-09-20"
      Then that claim is not flagged

    @negative
    Scenario: A non-Meals claim is never checked against the Meals policy
      Given Dana the employee has no other claims dated "2026-09-21"
      When Dana submits a Travel claim for "31000.00" LKR dated "2026-09-21"
      Then that claim is not flagged

  @story-11
  Rule: The employee sees the policy flag and its reason on their own claim

    Scenario: Dana sees why her claim was flagged
      Given Dana the employee has a Meals claim dated "2026-09-12" flagged for exceeding the daily limit
      When Dana opens that claim's detail
      Then she sees the flag and its plain-language reason

  @story-12
  Rule: The manager sees the policy flag and its reason when reviewing a direct report's claim

    Scenario: Priya sees why Dana's claim was flagged
      Given Priya the manager has a direct report Dana with a Meals claim dated "2026-09-12" flagged for exceeding the daily limit
      When Priya opens that claim in her approval queue
      Then she sees the flag and its plain-language reason

    Scenario: A flagged claim can still be approved
      Given Priya the manager has a direct report Dana with a pending, flagged Meals claim dated "2026-09-12"
      When Priya approves that claim with the comment "Approved despite flag, client dinner"
      Then the claim shows status "approved"
