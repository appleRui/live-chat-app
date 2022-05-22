<style scoped>
nav {
  padding: 20px;
  border-bottom: 1px solid #eee;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
nav p {
  margin: 2px auto;
  font-size: 16px;
  color: #444;
}
nav p.email {
  font-size: 14px;
  color: #999;
}
</style>
  
<template>
  <v-container>
    <Navbar />
    <ChatWindow :messages="messages" />
    <NewChatForm />
  </v-container>
</template>

<script>
import axios from 'axios'
import ChatWindow from '../components/ChatWindow'
import Navbar from '../components/Navbar'
import NewChatForm from '../components/NewChatForm'

export default {
    components: { Navbar, ChatWindow, NewChatForm },
  data () {
    return {
      messages: [],
    }
  },
  methods: {
    async getMessages () {
      try {
        const res = await axios.get('http://localhost:3001/messages', {
          headers: {
            uid: window.localStorage.getItem('uid'),
            "access-token": window.localStorage.getItem('access-token'),
            client:window.localStorage.getItem('client')
          }
        })
        if (!res) {
          new Error('メッセージ一覧を取得できませんでした')
        }
        this.messages = res.data
      } catch (err) {
        console.log(err)
      }
    },
  },
  mounted() {
    this.getMessages()
  },
}
</script>
