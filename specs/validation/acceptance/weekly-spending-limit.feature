Feature: Weekly team spending limit

  @story-9
  Rule: A manager can set a weekly spending limit for their team by describing it in plain language

    Scenario: Setting the team's weekly limit conversationally
      Given Priya the manager has no weekly limit set for her team
      When Priya tells the assistant to cap her team's spending at "$500 a week"
      Then her team's weekly limit is set to "500.00"

    Scenario: Replacing an existing weekly limit
      Given Priya the manager's team has a weekly limit of "500.00"
      When Priya tells the assistant to change her team's weekly limit to "650 a week"
      Then her team's weekly limit is set to "650.00"

  @story-10
  Rule: An employee sees their team's current weekly spending limit when submitting a claim

    Scenario: The limit is visible while filing a claim
      Given Dana the employee's team has a weekly limit of "500.00"
      When Dana starts submitting a new expense claim
      Then she sees her team's weekly limit of "500.00"

    @negative
    Scenario: No limit has been set yet
      Given Dana the employee's team has no weekly limit set
      When Dana starts submitting a new expense claim
      Then she sees that no weekly limit has been set for her team
