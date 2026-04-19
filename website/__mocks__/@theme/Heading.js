const React = require('react');
module.exports = function Heading({ children, ...props }) {
  return React.createElement('h3', props, children);
}
