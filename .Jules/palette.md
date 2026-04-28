## 2025-04-21 - Table Elements Parity and Async Lists Empty States
**Learning:** Table header (`<th>`) elements must maintain parity with table cell (`<td>`) elements within React components to avoid layout inconsistencies. Additionally, dynamically loaded lists require helpful empty states to manage user expectations gracefully when the API response contains no entries.
**Action:** When adding columns to data tables or rendering async data lists, verify table row configurations correspond evenly to table headers and always provide an empty state UI when no data is returned.
## 2026-04-28 - Keyboard Accessibility for Scrollable Containers
**Learning:** When making containers scrollable for responsiveness (e.g., `overflow-x: auto` or `overflowX: "auto"`), they become inaccessible to keyboard-only users who cannot scroll the content unless the container itself is focusable.
**Action:** Always include `tabIndex={0}`, `role="region"`, and a descriptive `aria-label` on scrollable container elements (like tables wrapped in responsive divs) to ensure keyboard accessibility.
