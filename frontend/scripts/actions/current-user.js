import { createAction } from 'redux-actions'
import * as currentUserApi from '../api/current-user'

const fetchStart = createAction('CURRENT_USER_FETCH_START')
const fetchSuccess = createAction('CURRENT_USER_FETCH_SUCCESS')
const fetchFail = createAction('CURRENT_USER_FETCH_FAIL')

export const fetch = () => (dispatch) => {
  dispatch(fetchStart())
  currentUserApi.fetch()
    .then((currentUser) => { dispatch(fetchSuccess(currentUser)) })
    .catch(() => { dispatch(fetchFail()) })
}

export const login = ({ email, password }) => (dispatch) => {
  currentUserApi.login({ email, password })
    .then((currentUser) => { dispatch(fetchSuccess(currentUser)) })
}
