import _ from 'lodash'
import React, { PureComponent, PropTypes } from 'react'
import Account from './account'

export default class List extends PureComponent {
  static propTypes = {
    accounts: PropTypes.object.isRequired
  }

  render() {
    const { accounts } = this.props

    return <table className="accounts_list">
      <thead>
        <tr>
          <th>Name</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        {_.map(accounts, (account, cid) =>
          <Account key={cid} account={account}/>
        )}
      </tbody>
    </table>
  }
}
