import { fromJS } from 'immutable'
import { camelCase, snakeCase, isArray, isPlainObject } from 'lodash'
import axios from 'axios'
import deepMapKeys from '../helpers/deep-map-keys'

axios.interceptors.request.use((request) => {
  if (request.data) request.data = deepMapKeys(request.data, snakeCase).toJS()
  return request
})

axios.interceptors.response.use((response) => {
  const { data } = response
  if (isPlainObject(data) || isArray(data)) response.data = deepMapKeys(fromJS(data), camelCase)
  return response
})
