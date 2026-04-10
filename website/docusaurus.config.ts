import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  title: 'Bluefin Framework Antigravity',
  tagline: 'Highly specialized, cryptographically signed, immutable OS for Framework 13',
  favicon: 'img/favicon.ico',

  future: {
    v4: true,
  },

  url: 'https://wtg-codes.github.io',
  baseUrl: '/bluefin-framework-antigravity/',

  organizationName: 'wtg-codes',
  projectName: 'bluefin-framework-antigravity',

  onBrokenLinks: 'throw',

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  plugins: [
    'docusaurus-plugin-image-zoom',
  ],
  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          editUrl:
            'https://github.com/wtg-codes/bluefin-framework-antigravity/tree/main/website/',
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    zoom: {
      selector: '.markdown :not(em) > img',
      config: {
        background: {
          light: 'rgb(255, 255, 255)',
          dark: 'rgb(50, 50, 50)'
        }
      }
    },
    image: 'img/docusaurus-social-card.jpg',
    colorMode: {
      defaultMode: 'dark',
      respectPrefersColorScheme: true,
    },
    navbar: {
      title: 'Bluefin Antigravity',
      logo: {
        alt: 'Bluefin Logo',
        src: 'img/logo.svg',
      },
      items: [
        {
          type: 'docSidebar',
          sidebarId: 'tutorialSidebar',
          position: 'left',
          label: 'Docs',
        },
        {to: '/dashboard', label: 'Dashboard', position: 'left'},
        {
          href: 'https://github.com/wtg-codes/bluefin-framework-antigravity',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Documentation',
          items: [
            {
              label: 'Architecture',
              to: '/docs/architecture',
            },
            {
              label: 'Security',
              to: '/docs/security',
            },
            {
              label: 'Operations',
              to: '/docs/ops',
            },
          ],
        },
        {
          title: 'Ecosystem',
          items: [
            {
              label: 'Project Bluefin',
              href: 'https://projectbluefin.io',
            },
            {
              label: 'BlueBuild',
              href: 'https://blue-build.org',
            },
          ],
        },
        {
          title: 'Community',
          items: [
            {
              label: 'Universal Blue Discord',
              href: 'https://discord.gg/ublue-os',
            },
          ],
        },
      ],
      copyright: "Copyright © " + new Date().getFullYear() + " Bluefin Framework Antigravity Project. Built with Docusaurus.",
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
