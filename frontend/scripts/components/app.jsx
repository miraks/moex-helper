import React, { PureComponent, PropTypes } from 'react'
import ImmutablePropTypes from 'react-immutable-proptypes'
import { connect } from 'react-redux'
import { Container } from 'muicss/react'
import * as currentUserActions from '../actions/current-user'
import Loader from './shared/loader'
import Header from './shared/header'
import LoginPage from './login/page'

class App extends PureComponent {
  static propTypes = {
    fetchCurrentUser: PropTypes.func.isRequired,
    isFetching: PropTypes.bool.isRequired,
    currentUser: ImmutablePropTypes.map,
    children: PropTypes.node.isRequired
  }

  componentWillMount() {
    const { fetchCurrentUser } = this.props
    fetchCurrentUser()
  }

  content() {
    const { isFetching, currentUser, children } = this.props

    if (isFetching) return <Loader/>
    if (!currentUser) return <LoginPage/>
    return children
  }

  render() {
    return <div className="layout">
      <Header/>
      <Container className="layout_content">
        {::this.content()}
      </Container>
    </div>
  }
}

const mapStateToProps = (state) => {
  return {
    isFetching: state.getIn(['currentUser', 'isFetching']),
    currentUser: state.getIn(['currentUser', 'item'])
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    fetchCurrentUser() { return dispatch(currentUserActions.fetch()) }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(App)
