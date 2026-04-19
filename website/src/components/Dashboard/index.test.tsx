import React from 'react';
import { render, screen, waitFor } from '@testing-library/react';
import Dashboard from './index';

// Mock fetch
global.fetch = jest.fn();

describe('Dashboard Component', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('renders loading state initially', () => {
    // Return a promise that doesn't resolve immediately to test loading state
    (global.fetch as jest.Mock).mockImplementationOnce(() => new Promise(() => {}));

    render(<Dashboard />);

    expect(screen.getByText('Loading build status...')).toBeInTheDocument();
    expect(screen.getByText('Live build status and image metadata for wtgOS.')).toBeInTheDocument();
  });

  it('renders workflow runs correctly after fetch', async () => {
    const mockData = {
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

    (global.fetch as jest.Mock).mockResolvedValueOnce({
      json: jest.fn().mockResolvedValueOnce(mockData)
    });

    render(<Dashboard />);

    // Wait for the loading state to disappear
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
    (global.fetch as jest.Mock).mockResolvedValueOnce({
      json: jest.fn().mockResolvedValueOnce({})
    });

    render(<Dashboard />);

    await waitFor(() => {
      expect(screen.queryByText('Loading build status...')).not.toBeInTheDocument();
    });

    expect(screen.queryByText('success')).not.toBeInTheDocument();
  });

  it('handles fetch errors gracefully', async () => {
    const consoleErrorSpy = jest.spyOn(console, 'error').mockImplementation(() => {});
    (global.fetch as jest.Mock).mockRejectedValueOnce(new Error('API failure'));

    render(<Dashboard />);

    await waitFor(() => {
      expect(screen.queryByText('Loading build status...')).not.toBeInTheDocument();
    });

    expect(consoleErrorSpy).toHaveBeenCalledWith('Failed to fetch workflow runs', expect.any(Error));

    consoleErrorSpy.mockRestore();
  });
});
