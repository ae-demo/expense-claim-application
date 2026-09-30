screen MyClaims "An employee's submitted expense claims and their status"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> UploadReceipt | Approvals -> ApprovalQueue"
  row
    heading "My Claims"
    right
    button "New Claim" primary -> UploadReceipt
  table "Vendor | Category | Amount | Date | Status | Policy"
    row "Riverside Bistro | Meals | LKR 4,250.00 | 2026-09-12 | Pending -> ClaimDetail | -"
    row "Office Depot | Office Supplies | LKR 1,820.00 | 2026-09-05 | Approved -> ClaimDetail | -"
    row "Acme Airlines | Travel | LKR 31,000.00 | 2026-08-28 | Rejected -> ClaimDetail | -"

screen UploadReceipt "Upload a receipt photo to start a new claim"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> UploadReceipt | Approvals -> ApprovalQueue"
  heading "Upload Receipt"
  card "Team weekly limit | LKR 50,000.00 | so far this week"
  text "Upload a photo of your receipt and we'll read the details for you"
  image "Receipt photo"
  row
    right
    button "Cancel" -> MyClaims
    button "Extract Details" primary -> ReviewClaim

screen ReviewClaim "Review and correct the auto-extracted receipt details before submitting"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> UploadReceipt | Approvals -> ApprovalQueue"
  heading "Review Claim"
  badge "Auto-extracted" ai
  select "Category: Meals"
  input "Amount"
  input "Expense Date"
  input "Vendor"
  row
    right
    button "Cancel" -> MyClaims
    button "Submit Claim" primary -> MyClaims

screen ClaimDetail "One claim's full details, editable while pending, with any policy flag"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> UploadReceipt | Approvals -> ApprovalQueue"
  heading "Claim Detail"
  row
    badge "Pending" warning
    badge "Over daily Meals policy" danger
  text "Vendor: Riverside Bistro"
  text "Category: Meals"
  text "Amount: LKR 4,250.00"
  text "Expense Date: 2026-09-12"
  text "Today's Meals claims total LKR 5,900.00, over the 5,000 LKR daily limit"
  image "Receipt photo"
  row
    right
    button "Withdraw" danger -> MyClaims
    button "Edit" -> ReviewClaim

screen ApprovalQueue "A manager's queue of claims submitted by their direct reports"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> UploadReceipt | Approvals -> ApprovalQueue | Team Limit -> SetWeeklyLimit"
  heading "Approval Queue"
  table "Employee | Vendor | Category | Amount | Status | Policy" -> ApprovalDetail
    row "Dana Lee | Riverside Bistro | Meals | LKR 4,250.00 | Pending | Flagged"
    row "Sam Ortiz | Acme Airlines | Travel | LKR 31,000.00 | Pending | -"

screen ApprovalDetail "A manager approves or rejects one direct report's claim, with a comment and any policy flag"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> UploadReceipt | Approvals -> ApprovalQueue | Team Limit -> SetWeeklyLimit"
  heading "Claim from Dana Lee"
  badge "Over daily Meals policy" danger
  text "Vendor: Riverside Bistro"
  text "Category: Meals"
  text "Amount: LKR 4,250.00"
  text "Expense Date: 2026-09-12"
  text "Today's Meals claims total LKR 5,900.00, over the 5,000 LKR daily limit"
  image "Receipt photo"
  textarea "Comment"
  row
    right
    button "Reject" danger -> ApprovalQueue
    button "Approve" primary -> ApprovalQueue

screen SetWeeklyLimit "A manager tells the assistant their team's weekly spending limit in plain language"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> UploadReceipt | Approvals -> ApprovalQueue | Team Limit -> SetWeeklyLimit"
  heading "Team Weekly Limit"
  card "Current limit | LKR 50,000.00 | set last Monday"
  list "Priya: cap spending at 50,000 LKR a week | Assistant: Got it — your team's weekly limit is now LKR 50,000.00"
  row
    input "Tell the assistant your team's new weekly limit"
    button "Send" primary // sends the chat message; stays on this screen

flow "File a claim"
  role "Employee"
  description "An employee uploads a receipt, reviews the extracted details, and tracks its status"
  MyClaims
  UploadReceipt
  ReviewClaim
  ClaimDetail

flow "Approval queue"
  role "Manager"
  description "A manager reviews and decides on their direct reports' submitted claims"
  ApprovalQueue
  ApprovalDetail
  SetWeeklyLimit
