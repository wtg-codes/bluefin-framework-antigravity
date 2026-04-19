import type { SidebarsConfig } from "@docusaurus/plugin-content-docs";

const sidebars: SidebarsConfig = {
  tutorialSidebar: [
    "intro",
    {
      type: "category",
      label: "Getting Started",
      items: ["installation"],
    },
    {
      type: "category",
      label: "Hardware",
      items: ["hardware"],
    },
    {
      type: "category",
      label: "Usage Guide",
      items: ["antigravity", "software"],
    },
    {
      type: "category",
      label: "Technical Reference",
      items: ["architecture", "security", "ops", "dashboard"],
    },
  ],
};

export default sidebars;
