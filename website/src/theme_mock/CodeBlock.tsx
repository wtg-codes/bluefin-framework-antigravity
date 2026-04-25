import React from 'react';

export default function CodeBlock({ children }: { children: React.ReactNode }) {
  return <pre><code>{children}</code></pre>;
}
