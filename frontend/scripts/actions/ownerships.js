import { createAction } from 'redux-actions'
import * as ownershipsApi from '../api/ownerships'

const fetchStart = createAction('OWNERSHIPS_FETCH_START')
const fetchSuccess = createAction('OWNERSHIPS_FETCH_SUCCESS')
const fetchFail = createAction('OWNERSHIPS_FETCH_FAIL')
const updateStart = createAction('OWNERSHIPS_UPDATE_START')
const updateSuccess = createAction('OWNERSHIPS_UPDATE_SUCCESS')
const updateFail = createAction('OWNERSHIPS_UPDATE_FAIL')
const removeStart = createAction('OWNERSHIPS_REMOVE_START')
const removeSuccess = createAction('OWNERSHIPS_REMOVE_SUCCESS')
const removeFail = createAction('OWNERSHIPS_REMOVE_FAIL')

export const fetch = () => (dispatch) => {
  dispatch(fetchStart())
  return ownershipsApi.fetch()
    .then((ownerships) => {
      dispatch(fetchSuccess(ownerships))
      return ownerships
    })
    .catch(() => { dispatch(fetchFail()) })
}

export const update = (cid, params) => (dispatch, getState) => {
  const id = getState().getIn(['ownerships', 'items', cid, 'id'])

  dispatch(updateStart(cid))
  return ownershipsApi.update(id, params)
    .then((ownership) => {
      dispatch(updateSuccess({ cid, ownership }))
      return ownership
    })
    .catch(() => { dispatch(updateFail(cid)) })
}

export const remove = (cid) => (dispatch, getState) => {
  const id = getState().getIn(['ownerships', 'items', cid, 'id'])

  if (!id) {
    dispatch(removeSuccess(cid))
    return Promise.resolve()
  }

  dispatch(removeStart(cid))
  return ownershipsApi.remove(id)
    .then(() => { dispatch(removeSuccess(cid)) })
    .catch(() => { dispatch(removeFail(cid)) })
}
