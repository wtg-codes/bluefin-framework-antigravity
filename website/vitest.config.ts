import { defineConfig } from 'vitest/config';
import react from '@vitejs/plugin-react';
import path from 'path';

export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: ['./src/test-setup.ts'],
  },
  resolve: {
    alias: {
      '@site': path.resolve(__dirname, '.'),
      '@theme/Heading': path.resolve(__dirname, 'src/theme_mock/Heading.tsx'),
      '@theme/Layout': path.resolve(__dirname, 'src/theme_mock/Layout.tsx'),
      '@theme': path.resolve(__dirname, 'src/theme_mock'),
      '@docusaurus/useDocusaurusContext': path.resolve(__dirname, 'src/theme_mock/useDocusaurusContext.ts'),
      '@docusaurus/Link': path.resolve(__dirname, 'src/theme_mock/Link.tsx'),
    },
  },
});
