module.exports = {
  preset: "ts-jest",
  testEnvironment: "jsdom",
  moduleNameMapper: {
    "^@docusaurus/useDocusaurusContext$": "<rootDir>/__mocks__/@docusaurus/useDocusaurusContext.js",
    "^@docusaurus/(.*)$": "<rootDir>/__mocks__/@docusaurus/$1.js",
    "^@theme/(.*)$": "<rootDir>/__mocks__/@theme/$1.js",
    "\\.module\\.css$": "identity-obj-proxy",
    "^@site/(.*)\\.svg$": "<rootDir>/__mocks__/svgMock.js"
  },
  setupFilesAfterEnv: ["<rootDir>/jest.setup.js", "<rootDir>/jest.setup.ts"],
  transform: {
    "^.+\\.(ts|tsx)$": [
      "ts-jest",
      {
        tsconfig: {
          jsx: "react-jsx",
        },
      },
    ],
  },
};
