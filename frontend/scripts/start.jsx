import React from 'react'
import ReactDOM from 'react-dom'
import { createStore, combineReducers, applyMiddleware } from 'redux'
import { Provider } from 'react-redux'
import { Router, Route, IndexRoute, browserHistory } from 'react-router'
import { syncHistoryWithStore, routerReducer } from 'react-router-redux'
import thunk from 'redux-thunk'
import { reducer as formReducer } from 'redux-form'
import reducers from './reducers'
import App from './components/app'
import Home from './components/home/page'

const store = createStore(
  combineReducers({
    ...reducers,
    routing: routerReducer,
    form: formReducer
  }),
  applyMiddleware(thunk)
)

const history = syncHistoryWithStore(browserHistory, store)

const rootEl = document.querySelector('#root')

ReactDOM.render(
  <Provider store={store}>
    <Router history={history}>
      <Route path="/" component={App}>
        <IndexRoute component={Home}/>
      </Route>
    </Router>
  </Provider>,
  rootEl
)
