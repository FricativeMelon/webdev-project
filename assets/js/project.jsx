import React from 'react';
import ReactDOM from 'react-dom';

export default function project_init(root) {
  ReactDOM.render(<Project />, root);
}

class Project extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return <div>
      <h2>Project loaded.</h2>
    </div>;
  }
}
