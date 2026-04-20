## 2026-04-20 - [Status Badge Contrast Accessibility]
**Learning:** The default pattern of using white text on yellow (`#ffc107`) status or warning badges fails WCAG contrast ratios, presenting an accessibility barrier for visually impaired users. This pattern is common when dynamically mapping a color array where white is assumed as a safe text color.
**Action:** When using warning/yellow indicator colors in dashboards or logs, explicitly override the text color to a dark value (e.g., `#212529`) to ensure the contrast ratio meets accessibility guidelines.
