import { vi } from "vitest";
import React from "react";
import { render, screen, waitFor } from "@testing-library/react";
import Dashboard from "./index";
import "@testing-library/jest-dom";

// Mock the useDocusaurusContext hook
vi.mock("@docusaurus/useDocusaurusContext", () => ({
  __esModule: true,
  default: () => ({
    siteConfig: {
      organizationName: "ublue-os",
      projectName: "bluefin",
    },
  }),
}));

describe("Dashboard Component", () => {
  let originalFetch: typeof global.fetch;
  let consoleErrorMock: any;

  beforeEach(() => {
    originalFetch = global.fetch;
    consoleErrorMock = vi.spyOn(console, "error").mockImplementation(() => {});
  });

  afterEach(() => {
    global.fetch = originalFetch;
    consoleErrorMock.mockRestore();
  });

  it("renders loading state initially", () => {
    // Mock fetch to return a promise that doesn't resolve immediately
    global.fetch = vi.fn(() => new Promise(() => {})) as any;

    render(<Dashboard />);

    expect(screen.getByText("Loading build status...")).toBeInTheDocument();
  });

  it("handles API fetch error and logs it, then stops loading", async () => {
    // Mock fetch to reject with an error
    const testError = new Error("Network error");
    global.fetch = vi.fn(() => Promise.reject(testError)) as any;

    render(<Dashboard />);

    // Check that loading text disappears
    await waitFor(() => {
      expect(
        screen.queryByText("Loading build status..."),
      ).not.toBeInTheDocument();
    });

    // Check that console.error was called with the correct arguments
    expect(consoleErrorMock).toHaveBeenCalledWith(
      "Failed to fetch workflow runs",
      testError,
    );

    // Check that the table renders (empty since workflowRuns is empty)
    expect(screen.getByText("Status")).toBeInTheDocument();
    expect(screen.getByText("Commit")).toBeInTheDocument();
  });

  it("handles successful API fetch and displays data", async () => {
    const mockRuns = {
      workflow_runs: [
        {
          id: 1,
          status: "completed",
          conclusion: "success",
          html_url: "https://github.com/example/run/1",
          head_commit: { message: "Test commit 1" },
          created_at: "2023-01-01T10:00:00Z",
          updated_at: "2023-01-01T10:05:00Z",
        },
      ],
    };

    global.fetch = vi.fn(() =>
      Promise.resolve({ json: () => Promise.resolve(mockRuns) }),
    ) as any;

    render(<Dashboard />);

    await waitFor(() => {
      expect(
        screen.queryByText("Loading build status..."),
      ).not.toBeInTheDocument();
    });

    expect(screen.getByText("Test commit 1")).toBeInTheDocument();
    expect(screen.getByText("success")).toBeInTheDocument();
  });
});
