import _ from 'lodash'
import React, { PureComponent, PropTypes } from 'react'
import { Input } from 'muicss/react'

export default class WrappedInput extends PureComponent {
  static propTypes = {
    input: PropTypes.object.isRequired
  }

  render() {
    const { input, ...other } = this.props
    const custom = _.omit(other, 'meta')

    return <Input {...input} {...custom}/>
  }
}
