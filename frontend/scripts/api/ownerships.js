import axios from 'axios'

export const fetch = () =>
  axios.get('/api/private/ownerships')
    .then(({ data }) => data.get('ownerships'))

export const create = (params) =>
  axios.post('/api/private/ownerships', { ownership: params })
    .then(({ data }) => data.get('ownership'))
