import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery;

export default function food_init(root, channel) {
  ReactDOM.render(<Food />, root);
}

class Food extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      foodList: [],
      date: new Date(),
      time: new Date()
    };
  }

  search() {
    this.edamam(this.myTextInput.value) 
  }

  foodClick(ev) {
    let state = this.state;
    state.foodList = state.foodList.map(i => i.name == ev.target.innerText? _.assign(i, i.active = true) : _.assign(i, i.active = false));
    this.setState(state);
    console.log(this.state);
  }

  setDate(ev) {
    let state = this.state;
    state = _.assign(state, state.date = new Date(ev.target.value));
    this.setState(state);
    console.log(state);
  }

  setTime(ev) {
    let state = this.state;
    console.log(ev.target.value);
    let e = _.split(ev.target.value, ":");
    let time = new Date();
    if (_.split(ev.target.value, ":")) {
      time.setHours(e[0]);
      time.setMinutes(e[1]);
    }
    state = _.assign(state, state.time = time);
    this.setState(state);
    console.log(state);
  }

  setCurrentTime() {
    let state = this.state;
    state = _.assign(state, state.date = new Date());
    state = _.assign(state, state.time = new Date());
    this.myDate.value = _.join([state.date.getFullYear(), state.date.getMonth() + 1, state.date.getDate()], "-");
    this.myTime.value = _.join([state.time.getHours().toString().padStart(2, "0"), state.time.getMinutes().toString().padStart(2, "0")], ":");
    this.setState(state);
  }

  submitClick() {
    console.log(this.state.foodList);
    //check food item is active/valid

    //check time and date are valid

    //make AJAX call to enter fooditem in database

    //on success redirect to home page
    this.redirect()
  }

  redirect() {
    let page = "http://localhost:4000"
    window.location.replace(page);
  }

  edamam(query) {
    console.log(query)
    console.log("/api/edamam/" + query);
    $.ajax("/api/edamam/" + query, {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        let state = this.state
        state = _.assign(state, state.foodList = resp);
        this.setState(state);
      },
    });
  }


  render() {
    const foodList = this.state.foodList;
    return <div>

        <div class="row">
            <div class="col">
                    <br/>
                    Food: <br/>
                    <input type="text" name="query" ref={ref => this.myTextInput = ref}/>
                    <button id="searchButton" class="btn btn-primary" onClick={() => this.search()}>Search</button>
                    <br/>

                    Time of Consumption: <br/>
                    <input type="date" name="date" onChange={(ev) => this.setDate(ev)} ref={ref => this.myDate = ref}/> 
                    <input type="time" name="time" onChange={(ev) => this.setTime(ev)} ref={ref => this.myTime = ref}/> 
                    <button class="btn btn-primary" onClick={() => this.setCurrentTime()}>Set to Current Time</button> 
                    <br/>
                    <br/>
                    <br/>

                    <div id="foodList">
                      <ul class="list-group">
                        {foodList.map(i => i.active? <li class="list-group-item list-group-item-primary" onClick={(ev) => this.foodClick(ev)}>{i.name}</li> : <li class="list-group-item list-group-item-secondary" onClick={(ev) => this.foodClick(ev)}>{i.name}</li>)}
                      </ul>
                    </div>
            </div>
            <div class="col">
                <br/>
                <EditableTable state={this.state}/>
                <button id="submitButton" class="btn btn-success" onClick={() => this.submitClick()}>Submit</button>
                <button id="cancelButton" class="btn btn-danger" onClick={() => this.redirect()}>Cancel</button>
            </div>
        </div>
    </div>;
  }
}

function EditableTable(props) {
  console.log(props.state.date);
  let nutrientCodes = [['Calcium', 'CA', 'mg', '1000'], ['Energy', 'ENERC_KCAL', 'kcal', '2000'], ['Carbs', 'CHOCDF', 'g', '300'], ['Niacin (B3)', 'NIA', 'mg', '16'], ['Cholesterol', 'CHOLE', 'mg', '10000'], ['Phosphorus', 'P', 'mg', '1250'], ['Monounsaturated', 'FAMS', 'g', '10'], ['Protein', 'PROCNT', 'g', '50'], ['Polyunsaturated', 'FAPU', 'g', '10'], ['Riboflavin (B2)', 'RIBF', 'mg', '1'], ['Sugars', 'SUGAR', 'g', '25'], ['Sugars added', 'SUGAR.added', 'g', '1'], ['Fat', 'FAT', 'g', '10'], ['Saturated', 'FASAT', 'g', '1'], ['Trans', 'FATRN', 'g', '1'], ['Vitamin E', 'TOCPHA', 'mg', '15'], ['Iron', 'FE', 'mg', '18'], ['Vitamin A', 'VITA_RAE', 'ug', '900'], ['Fiber', 'FIBTG', 'g', '30'], ['Vitamin B12', 'VITB12', 'ug', '2'], ['Folate (Equivalent)', 'FOLDFE', 'ug', '400'], ['Folate (food)', 'FOLFD', 'ug', '400'], ['Potassium', 'K', 'mg', '4700'], ['Vitamin C', 'VITC', 'mg', '90'], ['Magnesium', 'MG', 'mg', '420'], ['Vitamin D', 'VITD', 'ug', '20'], ['Sodium', 'NA', 'mg', '2000'], ['Vitamin K', 'VITK1', 'ug', '120'], ['Vitamin B6', 'VITB6A', 'mg', '1'], ['Thiamin (B1)', 'THIA', 'mg', '1']];
  console.log(_.map(nutrientCodes, i => _.get(_.get((_.find(props.state.foodList, ['active', true]) || {}), 'nutrition', {}), i, 0) ));
  return <div>
  <table class="table table-sm editableTable">
	<thead>
		<tr>
			<th scope="col">Nutrient</th>
			<th scope="col">Amount per Serving</th>
			<th scope="col">Percentage of Daily Values</th>
			<th scope="col">My Current Nutrition</th>
		</tr>
	</thead>
	<tbody>
{_.map(nutrientCodes, i => tableRow(i, props.state))}
	</tbody>
</table>
  </div>;
}

function tableRow(nutrient, state) {
  return <tr class={tableColor(nutrient[1], nutrient[3], state)}><th scope='row' name={nutrient[1]}>{nutrient[0]}</th><td>{tableValue(nutrient[1], state)} {nutrient[2]}</td><td>{tablePercentage(nutrient[1], nutrient[3], state)} %</td><td>{currentPercentage(nutrient[1], nutrient[3], state)} %</td></tr>;
}

function tableValue(code, state) {
  let myCode = _.join(["nutrition", code], ".");
  let myFood = (_.find(state.foodList, ['active', true]) || {'nutrition': {}});
  return parseFloat(_.get(myFood, myCode, 0)).toFixed(2);
}

function tablePercentage(code, intake, state) {
  let value = tableValue(code, state);
  //turn into percentage
  return parseInt((value / intake) * 100);
}

function currentPercentage(code, intake, state) {
  let percentage = tablePercentage(code, intake, state);
  //AJAX call for current nutrition percentage
  let current_percentage = 70.0;
  console.log(current_percentage + percentage);
  return parseInt(current_percentage + percentage);
}

function tableColor(code, intake, state) {
  let percentage = tablePercentage(code, intake, state);
  let total_percentage = currentPercentage(code, intake, state);
  if (percentage > 0.1) {
    if (total_percentage > 100) {
      return "table-danger";
    }
    if (total_percentage > 80) {
      return "table-warning";
    }
    return "table-primary";
  }
  return "table-dark";
}

