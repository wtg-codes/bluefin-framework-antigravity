import React from "react";
export default ({ children, to, ...props }: any) => (
  <a href={to} {...props}>
    {children}
  </a>
);
