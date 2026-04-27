## 2025-04-21 - Table Elements Parity and Async Lists Empty States
**Learning:** Table header (`<th>`) elements must maintain parity with table cell (`<td>`) elements within React components to avoid layout inconsistencies. Additionally, dynamically loaded lists require helpful empty states to manage user expectations gracefully when the API response contains no entries.
**Action:** When adding columns to data tables or rendering async data lists, verify table row configurations correspond evenly to table headers and always provide an empty state UI when no data is returned.
## 2026-04-27 - Keyboard Accessibility for Scrollable Tables
**Learning:** Responsive tables that use `overflow-x: auto` to enable horizontal scrolling on small screens become inaccessible to keyboard users because the scrollable container cannot receive focus.
**Action:** Always add `tabIndex={0}`, `role="region"`, and a descriptive `aria-label` to the scrollable container wrapper (`div`) around tables to ensure keyboard accessibility.
