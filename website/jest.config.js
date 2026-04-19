module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/jest.setup.ts'],
  moduleNameMapper: {
    '^@docusaurus/useDocusaurusContext$': '<rootDir>/src/__mocks__/@docusaurus/useDocusaurusContext.ts',
    '^@docusaurus/(.*)$': '<rootDir>/__mocks__/@docusaurus/$1.js',
  },
  transform: {
    '^.+\\.(ts|tsx)$': ['ts-jest', {
      tsconfig: {
        jsx: 'react-jsx',
      },
    }],
  },
};
