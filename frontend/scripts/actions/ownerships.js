import { createAction } from 'redux-actions'
import * as ownershipsApi from '../api/ownerships'

const fetchStart = createAction('OWNERSHIPS_FETCH_START')
const fetchSuccess = createAction('OWNERSHIPS_FETCH_SUCCESS')
const fetchFail = createAction('OWNERSHIPS_FETCH_FAIL')

export const fetch = () => (dispatch) => {
  dispatch(fetchStart())
  ownershipsApi.fetch()
    .then((ownerships) => { dispatch(fetchSuccess(ownerships)) })
    .catch(() => { dispatch(fetchFail()) })
}
