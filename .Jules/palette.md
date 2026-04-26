## 2024-04-26 - Accessible Scrollable Containers
**Learning:** Making table containers scrollable for responsiveness (`overflow-x: auto`) traps keyboard users unless explicitly handled, as they cannot pan the content without a mouse or touch device.
**Action:** Always include `tabIndex={0}`, `role="region"`, and a descriptive `aria-label` on responsive wrapper `div` elements to ensure full keyboard accessibility.
