import React, { PureComponent, PropTypes } from 'react'
import { connect } from 'react-redux'
import * as accountActions from '../../../actions/accounts'
import List from './list'
import Add from './add'

class AccountsPage extends PureComponent {
  static propTypes = {
    fetchAccounts: PropTypes.func.isRequired,
    addAccount: PropTypes.func.isRequired,
    accounts: PropTypes.object.isRequired
  }

  componentWillMount() {
    const { fetchAccounts } = this.props
    fetchAccounts()
  }

  render() {
    const { accounts, addAccount } = this.props

    return <div className="accounts">
      <Add onClick={addAccount}/>
      <List accounts={accounts}/>
    </div>
  }
}

const mapStateToProps = ({ accounts }) => {
  return {
    accounts: accounts.items
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    fetchAccounts() { return dispatch(accountActions.fetch()) },
    addAccount() { return dispatch(accountActions.add()) }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(AccountsPage)
