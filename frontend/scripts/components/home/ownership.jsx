import React, { PureComponent } from 'react'
import ImmutablePropTypes from 'react-immutable-proptypes'

export default class Ownership extends PureComponent {
  static propTypes = {
    ownership: ImmutablePropTypes.map.isRequired,
    columns: ImmutablePropTypes.listOf(ImmutablePropTypes.map).isRequired
  }

  render() {
    const { ownership, columns } = this.props

    return <tr>
      {columns.map((column) =>
        <td key={column.get('path')}>{ownership.getIn(column.get('path').split('.'))}</td>
      ).toJS()}
    </tr>
  }
}
