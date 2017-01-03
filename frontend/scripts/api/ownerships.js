import axios from 'axios'

export const create = (params) =>
  axios.post('/api/private/ownerships', { ownership: params })
    .then(({ data }) => data.get('ownership'))
