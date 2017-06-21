import React, { Component } from 'react';
import injectTapEventPlugin from 'react-tap-event-plugin';
import './App.css';
import Welcome from './Welcome';
// Needed for onTouchTap
// http://stackoverflow.com/a/34015469/988941
injectTapEventPlugin();

class App extends Component {
  constructor(props){
    super(props);
    this.state={
      loginPage:[],
      welcome:[]
    }
  }
  componentWillMount(){
    var loginPage =[];
    loginPage.push(<Welcome parentContext={this}/>);
    this.setState({
                  loginPage:loginPage
                    })
  }
  render() {
    return (
      <div className="App">
        {this.state.loginPage}
        {this.state.welcome}
      </div>
    );
  }
}
const style = {
  margin: 15,
};
export default App;
