const React = require('react');

module.exports = {
  default: React.forwardRef((props, ref) => {
    return React.createElement('svg', { ...props, ref });
  }),
  ReactComponent: React.forwardRef((props, ref) => {
    return React.createElement('svg', { ...props, ref });
  }),
};
