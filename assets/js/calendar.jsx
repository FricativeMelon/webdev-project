import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery;

export default function calendar_init(root, channel) {
  ReactDOM.render(<Calendar />, root);
}

class Calendar extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
     calendar_month: (new Date()).getMonth(),
     calendar_year: (new Date()).getFullYear(),
    }

  }

  render() {
    console.log(this.state);
    return <div class="container">
      {this.make_inner_calendar(this.state.calendar_month, this.state.calendar_year)}
    </div>;
  }
  
  make_inner_calendar(month, year){
    let days_in_month = (new Date(year, month + 1, 0)).getDate();
    let start_day = (new Date(year, month, 1)).getDay();
    console.log(days_in_month);
    console.log(start_day);
    let slots = []
    for (let i = 0; i < 35; i++) {
      let day = (i + 1) - start_day;
      if (day <= days_in_month && day > 0) {
        slots.push([day]);
      }
      else {
        slots.push([0]);
      }
    }
    return <div>
      {this.make_rows(slots, month, year)}
    </div>;
  }

  make_rows(slot, month, year) {
    let div = [];

    for(let i = 0; i < 5; i++) {
      let children = []
      for(let j = 0; j < 7; j++) {
        children.push(<div class="col">{this.make_day(slot[(i * 7) + j], month, year)}</div>)
      }

      div.push(<div class="row">{children}</div>)
    }
    return div;
  }

  is_day(day, month, year) {
    let today = new Date()
    if (today.getDate() == day && today.getMonth() == month && today.getFullYear() == year) {
      return "card-header bg-primary";
    }
    else {
      return "card-header";
    }
  }


  make_day(day, month, year) {
    //Going to add drop down menu button in card body
    //Drop down menu will have all food items from that day displayed
    let card_height = 8;
    if (day > 0) {
      return <div class="card border-primary mb-3 text-center" style={{height: card_height + 'em'}}>
        <div class={this.is_day(day, month, year)}>
	  {day}
	</div>
	<div class="card-body">
	  <div class="dropdown">
	    <button class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
	      
	    </button>
	  </div>
	</div>
      </div>;
    }
    else {
      return <div class="card text-white bg-secondary mb-3 text-center" style={{height: card_height + 'em'}}>
        
      </div>;
    }
  }
}

