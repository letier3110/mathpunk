import React from 'react';
import { Provider } from 'react-redux';
import { PersistGate } from 'redux-persist/integration/react';

import Navigator from './components/navigator/navigator';
import { store, persistor } from './store/store';

import './App.css';

function App() {
  return (
    <Provider store={store}>
      <PersistGate persistor={persistor} loading={null}>
        <div className="App">
          <Navigator />
        </div>
      </PersistGate>
    </Provider>
  );
}

export default App;
