import React from "react";
export default ({children, as: Component = "h3"}: any) => React.createElement(Component, null, children);
