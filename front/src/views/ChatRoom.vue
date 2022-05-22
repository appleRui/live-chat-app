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
    <NewChatForm @connectCable="connectCable" />
  </v-container>
</template>

<script>
import axios from 'axios'
import ChatWindow from '../components/ChatWindow'
import Navbar from '../components/Navbar'
import NewChatForm from '../components/NewChatForm'
import ActionCable from 'actioncable'

export default {
    components: { Navbar, ChatWindow, NewChatForm },
  data () {
    return {
      messages: [],
    }
  },
  mounted () {
    const cable = ActionCable.createConsumer('ws://localhost:3001/cable')
    this.messageChannel = cable.subscriptions.create('RoomChannel', {
      connected: () => {
        this.getMessages()
      },
      received: () => {
        this.getMessages()
      }
    })
  },
  beforeUnmount () { 
    this.messageChannel.unsubscribe()
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
      connectCable (message) {
      this.messageChannel.perform('receive', {
        message: message,
        email: window.localStorage.getItem('uid')
      })
    }
    // =======
  },
}
</script>
