<style lang="scss" scoped>
.the-login {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  .v-sheet.v-card:not(.v-sheet--outlined) {
    box-shadow: none;
  }
}
</style>

<template>
  <div class="the-login">
    <div class="the-login__innter">
      <v-card width="400px" class="text-center">
        <v-card-title tag="h1" class="d-block"> ログイン </v-card-title>
        <v-card-text>
          <v-form>
            <v-text-field
              v-model="user.email"
              type="text"
              label="メールアドレス"
              prepend-icon="mdi-account-circle"
            />
            <v-text-field
              v-model="user.password"
              type="password"
              label="パスワード"
              prepend-icon="mdi-lock"
              append-icon="mdi-eye-off"
            />
            <v-card-actions>
              <v-btn
                block
                tile
                color="primary"
                :disabled="disabled"
                @click.prevent="login"
                >ログイン</v-btn
              >
            </v-card-actions>
          </v-form>
        </v-card-text>
      </v-card>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { setStorage } from '@/services/localStorage'

export default {
    name: "TheLogin",
    data() {
      return {
        user: {
          email: null,
          password: null,
        }
      }
    },
    methods: {
      login(){
        axios.post('http://localhost:3001/auth/sign_in', this.user)
        .then((res) => {
          setStorage(res.headers, res.data.data.name)
          this.$router.push('/chatroom')
        })
        .catch((e) => {
          console.error(e.response)
          alert(e.response.data.errors[0])
        })
      }
    },
    computed: {
      disabled() {
        return !this.user.email || !this.user.password
      }
    }
}
</script>
