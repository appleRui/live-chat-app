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
import { getUid, getName, getAccessToken, getClient } from '@/services/localStorage'
import { removeStorage } from '@/services/localStorage'

export default {
  name: 'Systembar',
  data() {
    return {
      name: getName(),
      email: getUid()
    }
  },
  methods: {
    async logout () {
    try {
      const res = await axios.delete('http://localhost:3001/auth/sign_out', {
        headers: {
          "uid": this.email,
          "access-token": getAccessToken(),
          "client": getClient()
        }
      })
      alert("ログアウトしました")
      removeStorage()
      this.$router.push('/login')
      return res
    } catch (error) {
      console.log({ error })
    }
  }
  },
}
</script>