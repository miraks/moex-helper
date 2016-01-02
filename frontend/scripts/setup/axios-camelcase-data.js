import axios from 'axios'
import deepCamelCaseKeys from '../helpers/deep-camel-case-keys'

axios.interceptors.response.use((response) => {
  response.originalData = response.data
  response.data = deepCamelCaseKeys(response.data)
  return response
})
