## 2025-04-21 - Table Elements Parity and Async Lists Empty States
**Learning:** Table header (`<th>`) elements must maintain parity with table cell (`<td>`) elements within React components to avoid layout inconsistencies. Additionally, dynamically loaded lists require helpful empty states to manage user expectations gracefully when the API response contains no entries.
**Action:** When adding columns to data tables or rendering async data lists, verify table row configurations correspond evenly to table headers and always provide an empty state UI when no data is returned.

## 2025-04-30 - Scrollable Table Accessibility
**Learning:** Tables nested in scrollable containers (`overflow-x: auto`) for responsiveness become inaccessible to keyboard users because the container cannot receive focus.
**Action:** When making table containers scrollable for responsiveness, always include `tabIndex={0}`, `role="region"`, and a descriptive `aria-label` to ensure keyboard accessibility.
## 2026-04-20 - [Status Badge Contrast Accessibility]
**Learning:** The default pattern of using white text on yellow (`#ffc107`) status or warning badges fails WCAG contrast ratios, presenting an accessibility barrier for visually impaired users. This pattern is common when dynamically mapping a color array where white is assumed as a safe text color.
**Action:** When using warning/yellow indicator colors in dashboards or logs, explicitly override the text color to a dark value (e.g., `#212529`) to ensure the contrast ratio meets accessibility guidelines.
