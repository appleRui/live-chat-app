import axios from 'axios'
import { getUid, getAccessToken, getClient} from './localStorage'

const instance = axios.create({
  baseURL: 'http://localhost:3001',
});

instance.interceptors.request.use((config) => {
  config.headers = {
    "uid": getUid(),
    "access-token": getAccessToken(),
    "client": getClient()
  }
  return config
})

export default instance