import React, { useEffect, useState } from 'react';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';

export default function Dashboard() {
  const { siteConfig } = useDocusaurusContext();
  const REPO = `${siteConfig.organizationName}/${siteConfig.projectName}`;
  const [workflowRuns, setWorkflowRuns] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`https://api.github.com/repos/${REPO}/actions/workflows/build.yml/runs?per_page=5`)
      .then(res => res.json())
      .then(data => {
        setWorkflowRuns(data.workflow_runs || []);
        setLoading(false)
      })
      .catch(err => {
        console.error('Failed to fetch workflow runs', err);
        setLoading(false);
      });
  }, [REPO]);

  return (
    <section className="margin-vert--lg">
      <p>Live build status and image metadata for Bluefin Framework Antigravity.</p>

      <h2>Latest Builds</h2>
      {loading ? (
        <p>Loading build status...</p>
      ) : (
        <div style={{ overflowX: 'auto' }}>
          <table style={{ width: '100%', borderCollapse: 'collapse' }}>
            <thead>
              <tr style={{ borderBottom: '2px solid var(--ifm-color-emphasis-300)' }}>
                <th style={{ textAlign: 'left', padding: '10px' }}>Status</th>
                <th style={{ textAlign: 'left', padding: '10px' }}>Commit</th>
                <th style={{ textAlign: 'left', padding: '10px' }}>Started</th>
                <th style={{ textAlign: 'left', padding: '10px' }}>Duration</th>
              </tr>
            </thead>
            <tbody>
              {workflowRuns.map(run => (
                <tr key={run.id} style={{ borderBottom: '1px solid var(--ifm-color-emphasis-200)' }}>
                  <td style={{ padding: '10px' }}>
                    <span style={{
                      padding: '4px 8px',
                      borderRadius: '4px',
                      backgroundColor: run.conclusion === 'success' ? '#28a745' : run.conclusion === 'failure' ? '#dc3545' : '#ffc107',
                      color: 'white',
                      fontWeight: 'bold'
                    }}>
                      {run.status === 'completed' ? run.conclusion : run.status}
                    </span>
                  </td>
                  <td style={{ padding: '10px' }}>
                    <a href={run.html_url} target="_blank" rel="noopener noreferrer">
                      {run.head_commit.message.split('\n')[0].substring(0, 50)}
                    </a>
                  </td>
                  <td style={{ padding: '10px' }}>{new Date(run.created_at).toLocaleString()}</td>
                  <td style={{ padding: '10px' }}>
                    {run.conclusion ? `${Math.round((new Date(run.updated_at).getTime() - new Date(run.created_at).getTime()) / 60000)}m` : '--'}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      <div className="row margin-top--lg">
        <div className="col col--6">
          <div className="card">
            <div className="card__header">
              <h3>OCI Image</h3>
            </div>
            <div className="card__body">
              <p><strong>Registry:</strong> <code>ghcr.io</code></p>
              <p><strong>Image:</strong> <code>{REPO}</code></p>
              <p><strong>Tag:</strong> <code>latest</code></p>
            </div>
            <div className="card__footer">
              <a className="button button--primary" href={`https://github.com/${REPO}/pkgs/container/bluefin-framework-antigravity`} target="_blank">
                View on GHCR
              </a>
            </div>
          </div>
        </div>
        <div className="col col--6">
          <div className="card">
            <div className="card__header">
              <h3>Installation</h3>
            </div>
            <div className="card__body">
              <pre style={{ fontSize: '0.8rem' }}>
                <code>
                  rpm-ostree rebase ostree-unverified-registry:ghcr.io/{REPO}:latest
                </code>
              </pre>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
