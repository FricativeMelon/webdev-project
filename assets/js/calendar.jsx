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
    let start_date = new Date();
    this.state = {
     calendar_month: start_date.getMonth(),
     calendar_year: start_date.getFullYear(),
     calendar_selected_date: (new Date(start_date.getFullYear(), start_date.getMonth(), start_date.getDate())),
     calendar_foodList: [],
    };
    this.update_calendar_state_ajax(this.state);

  }

  render() {
    console.log(this.state);
    let months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    let days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    return <div class="container">
    <div class="row">
    <div class="col-8">

    <div class="card bg-dark mb-3 text-center">

      <div class="card-header text-white">
        <div class="container">
	  <div class="row">
	    <div class="col">
	      <button class="btn btn-primary rounded-circle" onClick={() => this.changeMonth(-1)}>prev</button>
	    </div>
	    <div class="col">
              <h5>{months[this.state.calendar_month]} {this.state.calendar_year}</h5>
	    </div>
	    <div class="col">
	      <button class="btn btn-primary rounded-circle" onClick={() => this.changeMonth(1)}>next</button>
	    </div>
	  </div>
  	  <div class="row">
	    {_.map(days, i => <div class="col">{i}</div>)}
	  </div>
	</div>
      </div>

      <div class="card-body">
        <div class="container">
          {this.make_inner_calendar(this.state.calendar_month, this.state.calendar_year)}
        </div>
      </div>
    </div>
    
    </div>

    <div class="col">
      <div class="accordion" id="accordionExample">

        <div class="card"  style={{maxWidth: 22 + 'em', wordWrap: "break-word"}} >
	  <div class="card-header" id="headingNutrition">
	   <h5 class="mb-0">
	     <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseNutrition">
	       Overview: {months[this.state.calendar_selected_date.getMonth()]} {this.state.calendar_selected_date.getDate()}, {this.state.calendar_selected_date.getFullYear()}
	     </button>
	   </h5>
	  </div>
	  <div id="collapseNutrition" class="collapse show" data-parent="#accordionExample">
            <div class="card-body">
	      {nutritionBars(sumNutrients(this.state.calendar_foodList))}
	    </div>
          </div>
	</div>
	{_.map(this.state.calendar_foodList, (i, j) => this.accordionCard(i, j))}

      </div>
    </div>

    </div>
    </div>;
    
  }

  accordionCard(food, index) {
    return <div class="card" style={{maxWidth: 22 + 'em'}} >
      <div class="card-header" id={_.join(['headingFood', index], '')}>
        <h5 class="mb-0">
	  <button class="btn btn-link" type="button" data-toggle="collapse" data-target={_.join(["#collapseFood", index], '')}>
	    {food.name} at {food.datetime.hour}:{(food.datetime.minute).toString().padStart(2, "0")}
	  </button>
	</h5>
      </div>
      <div id={_.join(["collapseFood", index], '')} class="collapse" data-parent="#accordionExample">
        <div class="card-body">
	  {nutritionBars(food.nutrients)}
	  <button class="btn btn-danger mt-3" data-id={index} onClick={(ev) => console.log(ev.target)}>Remove</button>
	</div>
      </div>
    </div>;
  }

  changeMonth(delta) {
    let month = this.state.calendar_month + delta;
    let year = this.state.calendar_year;
    if (month < 0){
      year = year - 1;
      month = 11;
    }
    if (month > 11) {
      year = year + 1;
      month = 0;
    }
    let state = this.state;
    state.calendar_month = month;
    state.calendar_year = year;
    this.update_calendar_state(state);
  }

  update_calendar_state(state) {
    this.setState(state);
  }

  update_calendar_state_ajax(state){
    let fooditem = {"name": "apple", "datetime": {"hour": 7, "minute": 33}, "nutrients": {"CA": 820, "MG": 20, "P": 101}};
    state.calendar_foodList = [fooditem, fooditem];
    this.update_calendar_state(state);
  }
  
  make_inner_calendar(month, year){
    let days_in_month = (new Date(year, month + 1, 0)).getDate();
    let start_day = (new Date(year, month, 1)).getDay();
    console.log(days_in_month);
    console.log(start_day);
    let slots = []
    for (let i = 0; i < 42; i++) {
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
    let start_day = (new Date(year, month, 1)).getDay();
    let days_in_month = (new Date(year, month + 1, 0)).getDate();
    let extra_week = 1;
    if ((start_day + days_in_month) <= 35) {
      extra_week = 0;
    }

    for(let i = 0; i < 5 + extra_week; i++) {
      let children = []
      for(let j = 0; j < 7; j++) {
        children.push(<div class="col">{this.make_day(slot[(i * 7) + j], month, year)}</div>)
      }

      div.push(<div class="row">{children}</div>)
    }
    return div;
  }

  is_day(day, month, year) {
    let today = new Date();
    let today_d = today.getDate();
    let today_m = today.getMonth();
    let today_y = today.getFullYear();
    let given = new Date(year, month, day);
    if (this.state.calendar_selected_date.getTime() == (new Date(year, month, day)).getTime()) {
      return "card bg-primary mb-3 card-block justify-content-center";
    }
    else if (today_d == day && today_m == month && today_y == year) {
      return "card bg-warning mb-3 card-block justify-content-center";
    }
    else {
      return "card border-primary mb-3 card-block justify-content-center";
    }
  }

  selectDate(ev) {
    console.log(ev.target.innerText);
    let date = new Date(this.state.calendar_year, this.state.calendar_month, ev.target.innerText);
    let state = this.state;
    state.calendar_selected_date = date;
    //AJAX here for food items, set food items and set state
    this.update_calendar_state_ajax(state);
  }

  make_day(day, month, year) {
    //Going to add drop down menu button in card body
    //Drop down menu will have all food items from that day displayed
    let card_height = 4;
    if (day > 0) {
      return <div class={this.is_day(day, month, year)} style={{height: card_height + 'em'}} onClick={(ev) => this.selectDate(ev)}>
        <div class="card-body">
	  <p class="card-text">
	    {day}
	  </p>
	</div>
      </div>;
    }
    else {
      return <div class="card text-white bg-secondary mb-3 text-center" style={{height: card_height + 'em'}}>
        
      </div>;
    }
  }

}

function sumNutrients(foodlist) {
  let codes = ['CA', 'ENERC_KCAL', 'CHOCDF', 'NIA', 'CHOLE', 'P', 'FAMS', 'PROCNT', 'FAPU', 'RIBF', 'SUGAR', 'SUGAR.added', 'FAT', 'FASAT', 'FATRN', 'TOCPHA', 'FE', 'VITA_RAE', 'FIBTG', 'VITB12', 'FOLDFE', 'FOLFD', 'K', 'VITC', 'MG', 'VITD', 'NA', 'VITK1', 'VITB6A', 'THIA'];
  let sum =  _.reduce(codes, (r, v) => _.assign(r, r[v] = _.sumBy(foodlist, _.join(['nutrients', v],'.'))), {});
  console.log(sum);
  sum = _.mapValues(sum, (i) => i===undefined? 0 : i);
  return sum;
}

function nutritionBars(nutrients, style = {height: 2 + "px"}) {
  console.log(nutrients);
  return _.map(nutrients, (i, j) => nutritionBar(j, i, style));
}

function nutritionBar(nutrient, value, myStyle) {
  let codes = {'CA': 'Calcium', 'ENERC_KCAL': 'Energy', 'CHOCDF': 'Carbs', 'NIA': 'Niacin (B3)', 'CHOLE': 'Cholesterol', 'P': 'Phosphorus', 'FAMS': 'Monounsaturated', 'PROCNT': 'Protein', 'FAPU': 'Polyunsaturated', 'RIBF': 'Riboflavin (B2)', 'SUGAR': 'Sugars', 'SUGAR.added': 'Sugars added', 'FAT': 'Fat', 'FASAT': 'Saturated', 'FATRN': 'Trans', 'TOCPHA': 'Vitamin E', 'FE': 'Iron', 'VITA_RAE': 'Vitamin A', 'FIBTG': 'Fiber', 'VITB12': 'Vitamin B12', 'FOLDFE': 'Folate (Equivalent)', 'FOLFD': 'Folate (food)', 'K': 'Potassium', 'VITC': 'Vitamin C', 'MG': 'Magnesium', 'VITD': 'Vitamin D', 'NA': 'Sodium', 'VITK1': 'Vitamin K', 'VITB6A': 'Vitamin B6', 'THIA': 'Thiamin (B1)'}

  let percentage = percentNutrient(nutrient, value);
  nutrient = _.get(codes, nutrient, "unknown")
  return <div> {nutrient}: {percentage}%
  <div class="progress" style={myStyle}>
    <div class={progressClass(percentage)} role="progressbar" style={{width: percentage + '%'}}></div>
  </div> </div>;
}

function progressClass(percentage) {
  if (percentage > 100){
    return "progress-bar progress-bar-striped progress-bar-animated bg-danger";
  }
  else if (percentage > 80) {
    return "progress-bar progress-bar-striped progress-bar-animated bg-warning";
  }
  else {
    return "progress-bar progress-bar-striped progress-bar-animated bg-primary";
  }
}

function percentNutrient(nutrient, value) {
  let daily_values = {'CA': '1000', 'ENERC_KCAL': '2000', 'CHOCDF': '50', 'NIA': '16', 'CHOLE': '10000', 'P': '1250', 'FAMS': '10', 'PROCNT': '50', 'FAPU': '10', 'RIBF': '1', 'SUGAR': '25', 'SUGAR.added': '1', 'FAT': '10', 'FASAT': '1', 'FATRN': '1', 'TOCPHA': '15', 'FE': '18', 'VITA_RAE': '900', 'FIBTG': '30', 'VITB12': '2', 'FOLDFE': '400', 'FOLFD': '400', 'K': '4700', 'VITC': '90', 'MG': '420', 'VITD': '20', 'NA': '2000', 'VITK1': '120', 'VITB6A': '1', 'THIA': '1'};
  let percentage = value / _.get(daily_values, nutrient, 1);
  percentage = percentage * 100;
  percentage = percentage.toFixed(2);
  return percentage;
}

