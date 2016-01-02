import React, { PureComponent, PropTypes } from 'react'
import { connect } from 'react-redux'
import { login } from '../../actions/current-user'
import LoginForm from './form'

class LoginPage extends PureComponent {
  static propTypes = {
    login: PropTypes.func.isRequired
  }

  handleSubmit({ email, password }) {
    this.props.login({ email, password })
  }

  render() {
    return <LoginForm onSubmit={::this.handleSubmit}/>
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    login({ email, password }) { dispatch(login({ email, password })) }
  }
}

export default connect(null, mapDispatchToProps)(LoginPage)
