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
import http from '@/services/http'
import { getUid, getName } from '@/services/localStorage'
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
      const res = await http.delete('auth/sign_out')
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