import React, { PureComponent } from 'react'
import ImmutablePropTypes from 'react-immutable-proptypes'

export default class Ownership extends PureComponent {
  static propTypes = {
    ownership: ImmutablePropTypes.map.isRequired
  }

  render() {
    const { ownership } = this.props

    return <tr>
      <td>{ownership.get('id')}</td>
    </tr>
  }
}
