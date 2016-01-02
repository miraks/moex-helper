import _ from 'lodash'

export default (obj) =>
  _.mapKeys(obj, (value, key) => _.camelCase(key))
