import { getUid, getAccessToken, getClient } from '@/services/localStorage'
import axios from 'axios'

const validate = async () => {
  try {
    const res = await axios.get('http://localhost:3001/auth/validate_token', {
      headers: {
        "uid": getUid(),
        'access-token': getAccessToken(),
        "client":  getClient()
      }
    })

    return res
  } catch (err) {
    console.error(err)
  }
}

const useValidate = () => {
  return {
    validate
  }
}

export default useValidate