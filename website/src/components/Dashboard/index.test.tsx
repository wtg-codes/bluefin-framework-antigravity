import React from 'react';
import { render, screen, waitFor } from '@testing-library/react';
import Dashboard from './index';
import '@testing-library/jest-dom';

// Mock the useDocusaurusContext hook
jest.mock('@docusaurus/useDocusaurusContext', () => ({
  __esModule: true,
  default: () => ({
    siteConfig: {
      organizationName: 'wtg-codes',
      projectName: 'bluefin-framework-antigravity',
    },
  }),
}));

describe('Dashboard Component', () => {
  let originalFetch: typeof global.fetch;
  let consoleErrorMock: jest.SpyInstance;

  beforeEach(() => {
    originalFetch = global.fetch;
    consoleErrorMock = jest.spyOn(console, 'error').mockImplementation(() => {});
  });

  afterEach(() => {
    global.fetch = originalFetch;
    consoleErrorMock.mockRestore();
  });

  it('renders loading state initially', () => {
    // Mock fetch to return a promise that doesn't resolve immediately
    global.fetch = jest.fn(() => new Promise(() => {}));

    render(<Dashboard />);

    expect(screen.getByText('Loading build status...')).toBeInTheDocument();
    expect(screen.getByText('Live build status and image metadata for wtgOS.')).toBeInTheDocument();
  });

  it('handles API fetch error and logs it, then stops loading', async () => {
    // Mock fetch to reject with an error
    const testError = new Error('Network error');
    global.fetch = jest.fn(() => Promise.reject(testError));

    render(<Dashboard />);

    // Check that loading text disappears
    await waitFor(() => {
      expect(screen.queryByText('Loading build status...')).not.toBeInTheDocument();
    });

    // Check that console.error was called with the correct arguments
    expect(consoleErrorMock).toHaveBeenCalledWith('Failed to fetch workflow runs', testError);

    // Check that the table renders (empty since workflowRuns is empty)
    expect(screen.getByText('Status')).toBeInTheDocument();
    expect(screen.getByText('Commit')).toBeInTheDocument();
  });

  it('handles successful API fetch and displays data', async () => {
    const mockRuns = {
      workflow_runs: [
        {
          id: 1,
          status: 'completed',
          conclusion: 'success',
          html_url: 'https://github.com/wtg-codes/bluefin-framework-antigravity/actions/runs/1',
          head_commit: { message: 'feat: add awesome feature' },
          created_at: '2024-04-19T10:00:00Z',
          updated_at: '2024-04-19T10:05:00Z',
        },
        {
          id: 2,
          status: 'in_progress',
          conclusion: null,
          html_url: 'https://github.com/wtg-codes/bluefin-framework-antigravity/actions/runs/2',
          head_commit: { message: 'fix: resolve bug' },
          created_at: '2024-04-19T11:00:00Z',
          updated_at: '2024-04-19T11:00:00Z',
        },
        {
          id: 3,
          status: 'completed',
          conclusion: 'failure',
          html_url: 'https://github.com/wtg-codes/bluefin-framework-antigravity/actions/runs/3',
          head_commit: { message: 'chore: update deps' },
          created_at: '2024-04-19T12:00:00Z',
          updated_at: '2024-04-19T12:05:00Z',
        }
      ]
    };

    global.fetch = jest.fn(() =>
      Promise.resolve({
        json: () => Promise.resolve(mockRuns)
      })
    ) as jest.Mock;

    render(<Dashboard />);

    await waitFor(() => {
      expect(screen.queryByText('Loading build status...')).not.toBeInTheDocument();
    });

    // Check if the runs are rendered
    expect(screen.getByText('success')).toBeInTheDocument();
    expect(screen.getByText('in_progress')).toBeInTheDocument();
    expect(screen.getByText('failure')).toBeInTheDocument();

    // Check commit messages
    expect(screen.getByText('feat: add awesome feature')).toBeInTheDocument();
    expect(screen.getByText('fix: resolve bug')).toBeInTheDocument();
    expect(screen.getByText('chore: update deps')).toBeInTheDocument();

    // Check static info
    expect(screen.getByText('ghcr.io')).toBeInTheDocument();
    expect(screen.getByText('wtg-codes/bluefin-framework-antigravity')).toBeInTheDocument();
  });

  it('handles fetch returning no workflow_runs gracefully', async () => {
    global.fetch = jest.fn(() =>
      Promise.resolve({
        json: () => Promise.resolve({})
      })
    ) as jest.Mock;

    render(<Dashboard />);

    await waitFor(() => {
      expect(screen.queryByText('Loading build status...')).not.toBeInTheDocument();
    });

    expect(screen.queryByText('success')).not.toBeInTheDocument();
  });
});
