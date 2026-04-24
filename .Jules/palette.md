## 2026-04-24 - Empty State Feedback
**Learning:** Dynamically loaded lists and tables missing an empty state can lead to poor UX when API responses are empty.
**Action:** Implemented a 'No workflow runs found' empty state for the Dashboard table component gracefully using `colSpan` across columns.
