## 2025-04-21 - Table Elements Parity and Async Lists Empty States
**Learning:** Table header (`<th>`) elements must maintain parity with table cell (`<td>`) elements within React components to avoid layout inconsistencies. Additionally, dynamically loaded lists require helpful empty states to manage user expectations gracefully when the API response contains no entries.
**Action:** When adding columns to data tables or rendering async data lists, verify table row configurations correspond evenly to table headers and always provide an empty state UI when no data is returned.

## 2026-05-02 - Accessible Scrollable Tables
**Learning:** Adding `overflow-x: auto` or similar scrolling styles to container elements for responsive tables renders them inaccessible to keyboard users unless they are specifically made focusable. Without `tabIndex={0}`, screen reader users may miss the scrollable content or be unable to navigate it properly.
**Action:** Always include `tabIndex={0}`, `role="region"`, and a descriptive `aria-label` (e.g., "Latest workflow runs") to scrollable table containers to ensure full keyboard and screen reader accessibility.
