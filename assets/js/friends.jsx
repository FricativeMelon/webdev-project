import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function friends_init(root, channel) {
  let friends = window.friends;
  let current_user = window.current_user;
  ReactDOM.render(<Friends friends={friends} current_user={current_user} channel={channel} />, root);
}

class Friends extends React.Component {
  constructor(props) {
    super(props);

    this.channel = props.channel;
    this.state = {
      messages: [],
      friends: props.friends,
      current_user: props.current_user
    };

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

  handle_friend_request(ev) {
    ev.preventDefault()
    let form = $("#friend-input-form")
    let email = form.find("[type=email]").val()
    this.create_friend(this.state.current_user, email)
  }

  create_friend(requester, accepter) {
    $.ajax("/ajax/friends", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({requester, accepter}),
      success: (resp) => {},
      error: (resp) => {},
    });
  }

  render() {
    return <div>
      <div className="row">
        <div className="column">
          <p>Hello Friends!</p>
	  <FriendsList friends={this.state.friends} />
	  <RenderFriendInput root={this} />
        </div>
      </div>
    </div>;
  }
}

function FriendsList(props) {
    let rows = _.map(props.friends, (ff, i) => <Friend key={i} friend={ff} />);
    return <div className="row">
      <div className="col-12">
	<table className="table table-striped">
	  <thead>
	    <tr>
	      <th>name</th>
	    </tr>
	  </thead>
	  <tbody>
	    {rows}
	  </tbody>
	</table>
      </div>
    </div>;
  }

  function Friend(props) {
    let {friend} = props;
    return <tr>
      <td>{friend}</td>
    </tr>;
  }

  function RenderFriendInput(props) {
      let {root} = props
      return <div className="col-6">
        <form id="friend-input-form" className="form-inline my-2">
          <input type="email" placeholder="email" />
          <input type="submit" value="Request Friend" className="btn btn-secondary" onClick={root.handle_friend_request.bind(root)}/>
        </form>
      </div>
  }

function Messages(props) {
  let {messages} = props;
  let mess = _.map(messages, (mm, i) => <Message message={mm} key={i} />)
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
