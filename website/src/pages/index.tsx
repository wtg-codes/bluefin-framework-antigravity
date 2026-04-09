import React from 'react';
import clsx from 'clsx';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import Heading from '@theme/Heading';

import styles from './index.module.css';

function HomepageHeader() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <header className={clsx('hero hero--primary', styles.heroBanner)}>
      <div className="container">
        <Heading as="h1" className="hero__title">
          {siteConfig.title}
        </Heading>
        <p className="hero__subtitle">{siteConfig.tagline}</p>
        <div className={styles.buttons}>
          <Link
            className="button button--secondary button--lg"
            to="/docs/intro">
            Get Started
          </Link>
          <Link
            className="button button--outline button--secondary button--lg margin-left--md"
            to="/dashboard">
            View Dashboard
          </Link>
        </div>
      </div>
    </header>
  );
}

export default function Home(): JSX.Element {
  const {siteConfig} = useDocusaurusContext();
  return (
    <Layout
      title={siteConfig.title}
      description={siteConfig.tagline}>
      <HomepageHeader />
      <main>
        <section className="padding-vert--xl">
          <div className="container">
            <div className="row">
              <div className="col col--4">
                <h3>Strict Immutability</h3>
                <p>Zero host-level GUI/CLI tools. System integrity maintained via atomic updates and Flathub/Homebrew isolation.</p>
              </div>
              <div className="col col--4">
                <h3>AI Quarantine</h3>
                <p>Isolated agentic development environment via declarative Distrobox containers with ROCm hardware acceleration.</p>
              </div>
              <div className="col col--4">
                <h3>Framework Optimized</h3>
                <p>Tailored kernel arguments and drivers specifically for the Framework Laptop 13 (Ryzen AI 9 HX 370).</p>
              </div>
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}
