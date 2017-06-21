import React, { Component } from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import AppBar from 'material-ui/AppBar';
import RaisedButton from 'material-ui/RaisedButton';
import TextField from 'material-ui/TextField';

class Welcome extends Component {
  constructor(props){
    super(props);
    this.state={
      welcome:[]
    }
  }
  render() {
    return (
      <div>
        <MuiThemeProvider>
          <div>
          <AppBar
             title="Welcome"
           />
         </div>
        </MuiThemeProvider>
      </div>
    );
  }
}

export default Welcome;
