import React from 'react';
import { render, screen } from '@testing-library/react';
import { describe, it, expect } from 'vitest';
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
      screen.getByText(/Docusaurus was designed from the ground up/i)
    ).toBeInTheDocument();
    expect(
      screen.getByText(/Docusaurus lets you focus on your docs/i)
    ).toBeInTheDocument();
    expect(
      screen.getByText(/Extend or customize your website layout/i)
    ).toBeInTheDocument();
  });

  it('renders SVG icons with correct roles', () => {
    render(<HomepageFeatures />);
    const svgs = screen.getAllByRole('img');
    expect(svgs).toHaveLength(3);
  });
});
