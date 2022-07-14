import http from '@/services/http'

const validate = async () => {
  try {
    const res = await http.get('/auth/validate_token')
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