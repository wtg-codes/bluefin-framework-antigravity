## 2025-04-21 - Table Elements Parity and Async Lists Empty States
**Learning:** Table header (`<th>`) elements must maintain parity with table cell (`<td>`) elements within React components to avoid layout inconsistencies. Additionally, dynamically loaded lists require helpful empty states to manage user expectations gracefully when the API response contains no entries.
**Action:** When adding columns to data tables or rendering async data lists, verify table row configurations correspond evenly to table headers and always provide an empty state UI when no data is returned.
## 2024-05-03 - Scrollable Region Accessibility
**Learning:** Making containers scrollable for responsiveness (e.g., `overflow-x: auto` for data tables) breaks accessibility if they cannot receive focus, preventing keyboard-only users from scrolling the content.
**Action:** When creating scrollable containers, always include `tabIndex={0}` to make them focusable, `role="region"` to define them as a distinct area, and a descriptive `aria-label` so screen readers announce their purpose.
