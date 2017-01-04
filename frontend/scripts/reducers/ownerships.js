import { Map } from 'immutable'
import { handleActions } from 'redux-actions'
import listToCidMap from '../helpers/list-to-cid-map'

const initialState = Map({
  items: Map(),
  isFetching: false,
  isFailed: false
})

export default handleActions({
  OWNERSHIPS_FETCH_START(state) {
    return state.merge({ isFetching: true, isFailed: false })
  },

  OWNERSHIPS_FETCH_SUCCESS(state, { payload: ownerships }) {
    const ownershipsMap = listToCidMap(ownerships)
    return state.merge({ items: ownershipsMap, isFetching: false, isFailed: false })
  },

  OWNERSHIPS_FETCH_FAIL(state) {
    return state.merge({ isFetching: false, isFailed: true })
  },

  OWNERSHIPS_UPDATE_SUCCESS(state, { payload: { cid, ownership } }) {
    return state.setIn(['items', cid], ownership.set('cid', cid))
  },

  OWNERSHIPS_REMOVE_SUCCESS(state, { payload: cid }) {
    return state.deleteIn(['items', cid])
  }
}, initialState)
