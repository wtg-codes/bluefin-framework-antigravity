import '@testing-library/jest-dom';
import { vi } from 'vitest';
import React from 'react';

// Mock Docusaurus features
vi.mock('@theme/Heading', () => ({
  default: ({ as: Component, children, ...props }: any) => {
    const Tag = Component || 'h3';
    return React.createElement(Tag, props, children);
  },
}));

vi.mock('@theme/Layout', () => ({
  default: ({ children }: any) => {
    return React.createElement('div', { 'data-testid': 'layout' }, children);
  },
}));

vi.mock('@docusaurus/Link', () => ({
  default: ({ children, to, ...props }: any) => {
    return React.createElement('a', { href: to, ...props }, children);
  },
}));

// Mock SVG imports
// This handles the require('@site/static/img/...') pattern
vi.mock('@site/static/img/undraw_docusaurus_mountain.svg', () => ({
  default: () => React.createElement('svg', { role: 'img' }),
}));
vi.mock('@site/static/img/undraw_docusaurus_tree.svg', () => ({
  default: () => React.createElement('svg', { role: 'img' }),
}));
vi.mock('@site/static/img/undraw_docusaurus_react.svg', () => ({
  default: () => React.createElement('svg', { role: 'img' }),
}));

vi.mock('@docusaurus/useDocusaurusContext', () => ({
  default: () => ({
    siteConfig: { title: 'Test Site', tagline: 'Test Tagline' }
  })
}));
