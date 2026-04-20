import { vi, MockInstance } from "vitest";
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
    sessionStorage.clear();
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

    await waitFor(() => {
      expect(consoleErrorMock).toHaveBeenCalledWith(
        "Failed to fetch workflow runs",
        testError,
      );
      expect(
        screen.queryByText("Loading build status..."),
      ).not.toBeInTheDocument();
    });
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

  it("uses cached data from sessionStorage if valid", async () => {
    const mockCachedRuns = {
      timestamp: Date.now(),
      data: [
        {
          id: 2,
          status: "completed",
          conclusion: "success",
          html_url: "https://github.com/example/run/2",
          head_commit: { message: "Cached commit" },
          created_at: "2023-01-02T10:00:00Z",
          updated_at: "2023-01-02T10:05:00Z",
        },
      ],
    };

    sessionStorage.setItem(
      "github_workflow_runs_ublue-os/bluefin",
      JSON.stringify(mockCachedRuns),
    );

    global.fetch = vi.fn();

    render(<Dashboard />);

    await waitFor(() => {
      expect(
        screen.queryByText("Loading build status..."),
      ).not.toBeInTheDocument();
    });

    expect(screen.getByText("Cached commit")).toBeInTheDocument();
    expect(global.fetch).not.toHaveBeenCalled();
  });

  it("handles JSON parse error in sessionStorage and falls back to fetch", async () => {
    // Set invalid JSON in sessionStorage
    sessionStorage.setItem(
      "github_workflow_runs_ublue-os/bluefin",
      "{ invalid json }",
    );

    const mockRuns = {
      workflow_runs: [
        {
          id: 3,
          status: "completed",
          conclusion: "success",
          html_url: "https://github.com/example/run/3",
          head_commit: { message: "Fetched after parse error" },
          created_at: "2023-01-03T10:00:00Z",
          updated_at: "2023-01-03T10:05:00Z",
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

    // Verify console.error was called
    expect(consoleErrorMock).toHaveBeenCalledWith(
      "Failed to parse cached workflow runs",
      expect.any(SyntaxError),
    );

    // Verify it fell back to fetching and displayed the data
    expect(screen.getByText("Fetched after parse error")).toBeInTheDocument();
    expect(global.fetch).toHaveBeenCalled();
  });
});
