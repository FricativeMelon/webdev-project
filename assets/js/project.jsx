import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function project_init(root, channel) {
  ReactDOM.render(<Project channel={channel} />, root);
}

class Project extends React.Component {
  constructor(props) {
    super(props);

    this.channel = props.channel;
    this.state = {messages: []};

    this.channel.join()
        .receive("ok", this.gotView.bind(this))
        .receive("error", resp => { console.log("Unable to join", resp) });
    this.channel.on("update", payload => {
      this.gotView(payload)
    })
  }

  gotView(view) {
    console.log("new view", view);
    this.setState(view.game);
  }

  sendMessage(ev) {
    this.channel.push("message", { letter: ev.key })
        .receive("ok", this.gotView.bind(this));
  }

  render() {
    return <div>
      <div className="row">
        <div className="column">
          <InputBox message={this.sendMessage.bind(this)} />
          <Messages messages={this.state.messages}/>
        </div>
      </div>
    </div>;
  }
}

function Messages(props) {
  let {messages} = props;
  let mess = _.map(messages, (mm) => <Message message={mm} />)
  return <div className="row">
    {mess}
  </div>
}

function Message(props) {
  let {message} = props;
  return <div className="column">{message}</div>
}

function InputBox(props) {
  return <div>
    <p>Type Your Message</p>
    <p><input type="text" onKeyPress={props.message} /></p>
  </div>;
}
