#!/bin/bash

# Configuration
REPO_URL="https://github.com/${GITHUB_REPOSITORY:-wtg-codes/bluefin-framework-antigravity}"
IMAGE_URL="ghcr.io/${GITHUB_REPOSITORY:-wtg-codes/bluefin-framework-antigravity}"
BUILD_BADGE="${REPO_URL}/actions/workflows/build.yml/badge.svg"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bluefin Framework Antigravity - Build Dashboard</title>
    <style>
        :root {
            --bg-color: #0d1117;
            --text-color: #c9d1d9;
            --accent-color: #58a6ff;
            --card-bg: #161b22;
            --border-color: #30363d;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            line-height: 1.6;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
        }
        header {
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 20px;
            margin-bottom: 30px;
            text-align: center;
        }
        h1 {
            color: var(--accent-color);
            margin-bottom: 10px;
        }
        .badge-container {
            margin: 15px 0;
        }
        .grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
        }
        @media (min-width: 768px) {
            .grid {
                grid-template-columns: 1fr 1fr;
            }
        }
        .card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 6px;
            padding: 20px;
        }
        .card h2 {
            margin-top: 0;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 10px;
            font-size: 1.25rem;
        }
        code {
            background-color: rgba(110, 118, 129, 0.4);
            padding: 0.2em 0.4em;
            border-radius: 6px;
            font-family: ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, Liberation Mono, monospace;
            font-size: 85%;
        }
        pre {
            background-color: #010409;
            padding: 16px;
            border-radius: 6px;
            overflow: auto;
            font-size: 85%;
        }
        pre code {
            background-color: transparent;
            padding: 0;
        }
        .status-tag {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            background-color: #238636;
            color: white;
        }
        footer {
            margin-top: 50px;
            text-align: center;
            font-size: 0.8rem;
            color: #8b949e;
        }
        a {
            color: var(--accent-color);
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Bluefin Framework Antigravity</h1>
            <p>Highly specialized, cryptographically signed, immutable OS for Framework 13.</p>
            <div class="badge-container">
                <a href="${REPO_URL}/actions/workflows/build.yml">
                    <img src="${BUILD_BADGE}" alt="Build Status">
                </a>
            </div>
        </header>

        <div class="grid">
            <div class="card">
                <h2>Latest Image</h2>
                <p><strong>Registry:</strong> <code>ghcr.io</code></p>
                <p><strong>Image:</strong> <code>${IMAGE_URL}</code></p>
                <p><strong>Tag:</strong> <span class="status-tag">latest</span></p>
                <p><a href="https://${IMAGE_URL}">View on GitHub Packages</a></p>
            </div>

            <div class="card">
                <h2>Hardware Support</h2>
                <ul>
                    <li><strong>Framework Laptop 13</strong></li>
                    <li>AMD Ryzen™ AI 300 Series</li>
                    <li>96GB DDR5-5600</li>
                    <li>2.8K Display (3:2)</li>
                    <li>ROCm Hardware Passthrough</li>
                </ul>
            </div>

            <div class="card" style="grid-column: 1 / -1;">
                <h2>Installation Instructions</h2>
                <p>1. Rebase to the unsigned image:</p>
                <pre><code>rpm-ostree rebase ostree-unverified-registry:${IMAGE_URL}:latest</code></pre>
                <p>2. Reboot and then rebase to the signed image:</p>
                <pre><code>rpm-ostree rebase ostree-image-signed:docker://${IMAGE_URL}:latest</code></pre>
                <p>3. Initialize the AI Quarantine environment:</p>
                <pre><code>ujust setup-antigravity</code></pre>
            </div>

            <div class="card">
                <h2>Verification</h2>
                <p>Verify the image signature with <code>cosign</code>:</p>
                <pre><code>cosign verify --key cosign.pub ${IMAGE_URL}</code></pre>
            </div>

            <div class="card">
                <h2>Resources</h2>
                <ul>
                    <li><a href="${REPO_URL}">GitHub Repository</a></li>
                    <li><a href="${REPO_URL}/blob/main/ARCHITECTURE.md">Architecture ADRs</a></li>
                    <li><a href="${REPO_URL}/blob/main/OPS.md">Operations Runbook</a></li>
                    <li><a href="${REPO_URL}/blob/main/SECURITY.md">Security Model</a></li>
                </ul>
            </div>
        </div>

        <footer>
            Dashboard generated on ${TIMESTAMP} | Built with BlueBuild
        </footer>
    </div>
</body>
</html>
EOF
