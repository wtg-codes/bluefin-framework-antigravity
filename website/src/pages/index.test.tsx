import React from "react";
import { render, screen } from "@testing-library/react";
import { describe, it, expect } from "vitest";
import Home from "./index";

describe("Home Page", () => {
  it("renders the homepage with correct site config", () => {
    render(<Home />);

    // Check if header title is from siteConfig (mocked as 'Test Site' in test-setup)
    expect(screen.getByText("Test Site")).toBeInTheDocument();

    // Check if tagline is rendered
    expect(screen.getByText("Test Tagline")).toBeInTheDocument();

    // Check if the link to tutorial is present
    const link = screen.getByRole("link", { name: /Docusaurus Tutorial/i });
    expect(link).toBeInTheDocument();
    expect(link).toHaveAttribute("href", "/docs/intro");

    // Check if HomepageFeatures are rendered (by checking a text from them if not mocked)
    // The features component is not mocked, so it will render the actual component.
    expect(screen.getByText("Easy to Use")).toBeInTheDocument();
  });
});
