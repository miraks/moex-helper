import { Map } from 'immutable'
import uuid from 'uuid/v4'

export default (items) =>
  items.reduce((map, item) => {
    const cid = uuid()
    return map.set(cid, item.set('cid', cid))
  }, Map())
