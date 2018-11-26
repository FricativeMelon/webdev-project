import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery;
//import sumNutrients from './calendar';
//import nutritionBars from './calendar';

export default function stats_init(root, channel) {
  ReactDOM.render(<Stats />, root);
}

class Stats extends React.Component {
  constructor(props) {
    super(props);
    let today = new Date();
    this.state = {
     stats_today: today,
     stats_foodList: [],
    };
    this.update_stats_state_ajax(this.state);

  }

  componentDidMount() {
    this.interval = setInterval(() => this.update_stats_state_ajax(this.state), 10000);
  }

  componentWillUnmount() {
    clearInterval(this.interval);
  }

  render() {
    return <div class="container">
      <div class="row">
        <div class="col">
	  <div class="accordion" id="accordionStats">
	    <div class="card">
	      <div class="card-header" id ="headingStats">
	        <h5 class="mb-0">
		  <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseStats">
		    My Nutrition Overview
		  </button>
		</h5>
	      </div>
	      <div id="collapseStats" class="collapse" data-parent="#accordionStats">
	        <div class="card-body">
		  {nutritionBars(sumNutrients(this.state.stats_foodList), {height: 4 + "px"})}
		</div>
	      </div>
	    </div>
	  </div>
	</div>
      </div>
    </div>;
  }

  update_stats_state_ajax(state) {
    let fooditem = {"name": "apple", "datetime": {"hour": 7, "minute": 33}, "nutrients": {"CA": 820, "MG": 20, "P": 101}};
    state.stats_foodList = [fooditem, fooditem];
    this.setState(state);
    console.log(new Date());
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

