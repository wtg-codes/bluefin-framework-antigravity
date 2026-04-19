import React from 'react';
import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom';
import HomepageFeatures from './index';

describe('HomepageFeatures', () => {
  it('renders all features from the list', () => {
    render(<HomepageFeatures />);

    expect(screen.getByText('Easy to Use')).toBeInTheDocument();
    expect(screen.getByText('Focus on What Matters')).toBeInTheDocument();
    expect(screen.getByText('Powered by React')).toBeInTheDocument();
  });

  it('renders descriptions for each feature', () => {
    render(<HomepageFeatures />);

    expect(
      screen.getByText(/Built for Computing students and Multi-Agent/i)
    ).toBeInTheDocument();
    expect(
      screen.getByText(/Based on Bluefin-DX with a read-only root/i)
    ).toBeInTheDocument();
    expect(
      screen.getByText(/Isolated AI agent execution with direct hardware passthrough/i)
    ).toBeInTheDocument();
  });
});
