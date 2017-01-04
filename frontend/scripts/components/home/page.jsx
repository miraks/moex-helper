import React, { PureComponent, PropTypes } from 'react'
import ImmutablePropTypes from 'react-immutable-proptypes'
import { fromJS } from 'immutable'
import { connect } from 'react-redux'
import { t } from '../../helpers/i18n'
import * as ownershipActions from '../../actions/ownerships'
import Ownership from './ownership'

class HomePage extends PureComponent {
  static propTypes = {
    fetchOwnerships: PropTypes.func.isRequired,
    ownerships: ImmutablePropTypes.map.isRequired
  }

  constructor(props) {
    super(props)

    this.state = {
      columns: fromJS([
        { name: 'Account', path: 'account.name' },
        { name: 'ISIN', path: 'security.isin' },
        { name: t('en.security.data.secname'), path: 'security.data.secname' },
        { name: 'Amount', path: 'amount' },
        { name: 'Original price', path: 'price' },
        { name: t('en.security.data.prevprice'), path: 'security.data.prevprice' },
        { name: t('en.security.data.marketprice'), path: 'security.data.marketprice' },
        { name: t('en.security.data.couponvalue'), path: 'security.data.couponvalue' },
        { name: t('en.security.data.nextcoupon'), path: 'security.data.nextcoupon' },
        { name: t('en.security.data.matdate'), path: 'security.data.matdate' }
      ])
    }
  }

  componentWillMount() {
    const { fetchOwnerships } = this.props
    fetchOwnerships()
  }

  render() {
    const { ownerships } = this.props
    const { columns } = this.state

    return <table>
      <thead>
        <tr>
          {columns.map((column) =>
            <th key={column.get('path')}>{column.get('name')}</th>
          ).toJS()}
        </tr>
      </thead>
      <tbody>
        {ownerships.valueSeq().map((ownership) =>
          <Ownership key={ownership.get('id')} ownership={ownership} columns={columns}/>
        ).toJS()}
      </tbody>
    </table>
  }
}

const mapStateToProps = (state) => {
  return {
    ownerships: state.getIn(['ownerships', 'items'])
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    fetchOwnerships() { return dispatch(ownershipActions.fetch()) }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(HomePage)
