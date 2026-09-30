screen MyClaims "An employee's submitted expense claims and their status"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> UploadReceipt | Approvals -> ApprovalQueue"
  row
    heading "My Claims"
    right
    button "New Claim" primary -> UploadReceipt
  table "Vendor | Category | Amount | Date | Status"
    row "Riverside Bistro | Meals | $42.50 | 2026-09-12 | Pending -> ClaimDetail"
    row "Office Depot | Office Supplies | $18.20 | 2026-09-05 | Approved -> ClaimDetail"
    row "Acme Airlines | Travel | $310.00 | 2026-08-28 | Rejected -> ClaimDetail"

screen UploadReceipt "Upload a receipt photo to start a new claim"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> UploadReceipt | Approvals -> ApprovalQueue"
  heading "Upload Receipt"
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

screen ClaimDetail "One claim's full details, editable while pending"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> UploadReceipt | Approvals -> ApprovalQueue"
  heading "Claim Detail"
  badge "Pending" warning
  text "Vendor: Riverside Bistro"
  text "Category: Meals"
  text "Amount: $42.50"
  text "Expense Date: 2026-09-12"
  image "Receipt photo"
  row
    right
    button "Withdraw" danger -> MyClaims
    button "Edit" -> ReviewClaim

screen ApprovalQueue "A manager's queue of claims submitted by their direct reports"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> UploadReceipt | Approvals -> ApprovalQueue"
  heading "Approval Queue"
  table "Employee | Vendor | Category | Amount | Status" -> ApprovalDetail
    row "Dana Lee | Riverside Bistro | Meals | $42.50 | Pending"
    row "Sam Ortiz | Acme Airlines | Travel | $310.00 | Pending"

screen ApprovalDetail "A manager approves or rejects one direct report's claim, with a comment"
  navbar "Expense Claims"
  sidebar "My Claims -> MyClaims | New Claim -> UploadReceipt | Approvals -> ApprovalQueue"
  heading "Claim from Dana Lee"
  text "Vendor: Riverside Bistro"
  text "Category: Meals"
  text "Amount: $42.50"
  text "Expense Date: 2026-09-12"
  image "Receipt photo"
  textarea "Comment"
  row
    right
    button "Reject" danger -> ApprovalQueue
    button "Approve" primary -> ApprovalQueue

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
