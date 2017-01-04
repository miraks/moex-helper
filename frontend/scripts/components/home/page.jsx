import React, { PureComponent, PropTypes } from 'react'
import ImmutablePropTypes from 'react-immutable-proptypes'
import { connect } from 'react-redux'
import * as ownershipActions from '../../actions/ownerships'
import Ownership from './ownership'

class HomePage extends PureComponent {
  static propTypes = {
    fetchOwnerships: PropTypes.func.isRequired,
    ownerships: ImmutablePropTypes.map.isRequired
  }

  componentWillMount() {
    const { fetchOwnerships } = this.props
    fetchOwnerships()
  }

  render() {
    const { ownerships } = this.props

    return <table>
      <thead>
        <tr>
          <th>id</th>
        </tr>
      </thead>
      <tbody>
        {ownerships.valueSeq().map((ownership) =>
          <Ownership key={ownership.get('id')} ownership={ownership}/>
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
