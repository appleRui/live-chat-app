<style lang="scss" scoped>
.logout-btn {
  cursor: pointer;
}
</style>

<template>
  <v-system-bar dark color="primary" height="25">
    <span>
      こんにちは、<span class="name">{{ name }}</span
      >さん
    </span>
    <v-spacer></v-spacer>
    <div class="logout-btn" @click="logout">
      <span>ログアウト</span>
      <v-icon>mdi-logout</v-icon>
    </div>
  </v-system-bar>
</template>

<script>
import axios from 'axios'

export default {
  name: 'Systembar',
  data() {
    return {
      name: window.localStorage.getItem('name'),
      email: window.localStorage.getItem('uid')
    }
  },
  methods: {
    async logout () {
    try {
      const res = await axios.delete('http://localhost:3001/auth/sign_out', {
        headers: {
          uid: this.email,
          "access-token": window.localStorage.getItem('access-token'),
          client: window.localStorage.getItem('client')
        }
      })
      console.log("ログアウトしました")
      window.localStorage.removeItem('access-token')
      window.localStorage.removeItem('client')
      window.localStorage.removeItem('uid')
      window.localStorage.removeItem('name')
      this.$router.push('/login')
      return res
    } catch (error) {
      console.log({ error })
    }
  }
  },
}
</script>