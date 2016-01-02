import { handleActions } from 'redux-actions'

const initialState = {
  item: null,
  isFetching: false,
  isFailed: false
}

export default handleActions({
  CURRENT_USER_FETCH_START(state) {
    return { ...state, isFetching: true, isFailed: false }
  },

  CURRENT_USER_FETCH_SUCCESS(state, { payload: user }) {
    return { ...state, item: user, isFetching: false, isFailed: false }
  },

  CURRENT_USER_FETCH_FAIL(state) {
    return { ...state, isFetching: false, isFailed: true }
  }
}, initialState)
