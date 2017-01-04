import { Map } from 'immutable'

let translations = Map()

export const set = (trs) => {
  translations = trs
}

export const t = (path) =>
  translations.getIn(path)
