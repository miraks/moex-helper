import _ from 'lodash'
import camelCaseKeys from './camel-case-keys'

const deepCamelCaseKeys = (obj) => {
  if (_.isArray(obj)) return obj.map(deepCamelCaseKeys)
  return _.mapValues(camelCaseKeys(obj), (value) => {
    if (_.isPlainObject(value) || _.isArray(value)) return deepCamelCaseKeys(value)
    return value
  })
}

export default deepCamelCaseKeys
