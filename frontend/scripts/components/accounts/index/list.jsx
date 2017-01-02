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
        {accounts.valueSeq().map((account) =>
          <Account key={account.get('cid')} account={account}/>
        ).toJS()}
      </tbody>
    </table>
  }
}
