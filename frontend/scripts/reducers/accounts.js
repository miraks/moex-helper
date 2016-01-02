import _ from 'lodash'
import uuid from 'uuid/v4'
import { handleActions } from 'redux-actions'

const initialState = {
  items: {},
  isFetching: false,
  isFailed: false
}

export default handleActions({
  ACCOUNTS_FETCH_START(state) {
    return { ...state, isFetching: true, isFailed: false }
  },

  ACCOUNTS_FETCH_SUCCESS(state, { payload: accounts }) {
    const accountsMap = _(accounts)
      .map((account) => { return { ...account, cid: uuid() } })
      .keyBy('cid')
      .value()

    return { ...state, items: accountsMap, isFetching: false, isFailed: false }
  },

  ACCOUNTS_FETCH_FAIL(state) {
    return { ...state, isFetching: false, isFailed: true }
  },

  ACCOUNTS_ADD(state) {
    const account = { cid: uuid() }
    return { ...state, items: { ...state.items, [account.cid]: account } }
  },

  ACCOUNTS_SAVE_SUCCESS(state, { payload: { cid, account } }) {
    return { ...state, items: { ...state.items, [cid]: { ...account, cid } } }
  },

  ACCOUNTS_REMOVE_SUCCESS(state, { payload: cid }) {
    return { ...state, items: _.omit(state.items, cid) }
  }
}, initialState)
