export const setStorage = (headers, name) => {
  window.localStorage.setItem('access-token', headers['access-token'])
  window.localStorage.setItem('client', headers.client)
  window.localStorage.setItem('uid', headers.uid)
  window.localStorage.setItem('name', name)
}

export const removeStorage = () => {
  window.localStorage.removeItem('access-token')
  window.localStorage.removeItem('client')
  window.localStorage.removeItem('uid')
  window.localStorage.removeItem('name')
}

export const getUid = () => {
  return window.localStorage.getItem('uid')
}

export const getAccessToken = () => {
  return window.localStorage.getItem('access-token')
}

export const getClient = () => {
  return window.localStorage.getItem('client')
}

export const getName = () => {
  return window.localStorage.getItem('name')
}