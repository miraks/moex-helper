import React, { PureComponent, PropTypes } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form'
import { Button } from 'muicss/react'
import * as accountActions from '../../../actions/accounts'
import Input from '../../shared/input'

class Account extends PureComponent {
  static propTypes = {
    account: PropTypes.object.isRequired,
    save: PropTypes.func.isRequired,
    remove: PropTypes.func.isRequired,
    handleSubmit: PropTypes.func.isRequired
  }

  constructor(props) {
    super(props)

    const { account } = props

    this.state = {
      edit: !account.id
    }
  }

  name() {
    const { account } = this.props
    const { edit } = this.state

    if (!edit) return account.name

    return <Field name="name" type="text" hint="Name" component={Input}/>
  }

  edit() {
    const { edit } = this.state

    if (edit) return null

    const startEdit = () => { this.setState({ edit: true }) }
    return <Button onClick={startEdit}>Edit</Button>
  }

  save() {
    const { save, handleSubmit } = this.props
    const { edit } = this.state

    if (!edit) return null

    const onSubmit = (params) => {
      save(params).then(() => { this.setState({ edit: false }) })
    }

    return <Button onClick={handleSubmit(onSubmit)}>Save</Button>
  }

  render() {
    const { remove } = this.props

    return <tr className="accounts_account">
      <td>{::this.name()}</td>
      <td>
        {::this.edit()}
        {::this.save()}
        <Button onClick={remove}>Remove</Button>
      </td>
    </tr>
  }
}

const mapStateToProps = (state, { account }) => {
  return { form: `account-${account.cid}` }
}

const mapDispatchToProps = (dispatch, { account }) => {
  return {
    save(params) { return dispatch(accountActions.save(account.cid, params)) },
    remove() { return dispatch(accountActions.remove(account.cid)) }
  }
}

export default compose(connect(mapStateToProps, mapDispatchToProps), reduxForm())(Account)
