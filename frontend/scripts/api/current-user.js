import axios from 'axios'

export const fetch = () =>
  axios.get('/api/private/current_user')
    .then(({ data }) => data.currentUser)

export const login = ({ email, password }) =>
  axios.post('/api/private/session', { email, password })
    .then(({ data }) => data.currentUser)
