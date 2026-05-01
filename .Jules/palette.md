## 2025-04-21 - Table Elements Parity and Async Lists Empty States
**Learning:** Table header (`<th>`) elements must maintain parity with table cell (`<td>`) elements within React components to avoid layout inconsistencies. Additionally, dynamically loaded lists require helpful empty states to manage user expectations gracefully when the API response contains no entries.
**Action:** When adding columns to data tables or rendering async data lists, verify table row configurations correspond evenly to table headers and always provide an empty state UI when no data is returned.
## 2026-05-01 - Scrollable Table Accessibility
**Learning:** Making table containers scrollable for responsiveness (`overflow-x: auto`) creates an accessibility barrier for keyboard-only users who cannot scroll the content if the container is not focusable.
**Action:** Always include `tabIndex={0}`, `role="region"`, and a descriptive `aria-label` on scrollable table containers to ensure full keyboard navigation and screen reader support.
