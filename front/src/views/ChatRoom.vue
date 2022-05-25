<style scoped>
.container {
  display: flex;
  height: calc(100vh - 25px);
}
.chat-container {
  width: 80%;
}
</style>
  
<template>
  <v-main>
    <Systembar />
    <div class="container">
      <ChatSidebar :chatrooms="chatrooms" />
      <div class="chat-container">
        <ChatWindow
          @connectCable="connectCable"
          :messages="formattedMessages"
          ref="chatWindow"
        />
        <NewChatForm @connectCable="connectCable" />
      </div>
    </div>
  </v-main>
</template>

<script>
import ActionCable from 'actioncable'
import axios from 'axios'
import ChatWindow from '../components/ChatWindow'
import ChatSidebar from '@/components/ChatSidebar.vue'
import Systembar from '@/components/Systembar.vue'
import NewChatForm from '../components/NewChatForm'
import { formatDistanceToNow } from 'date-fns'
import { ja } from 'date-fns/locale'

export default {
  components: { Systembar, ChatSidebar, ChatWindow, NewChatForm },
  data () {
    return {
      chatrooms: [],
      messages: [],
    }
  },
  async created() {
    try {
        const res = await axios.get('http://localhost:3001/rooms', {
          headers: {
            uid: window.localStorage.getItem('uid'),
            "access-token": window.localStorage.getItem('access-token'),
            client:window.localStorage.getItem('client')
          }
        })
        this.chatrooms = res.data
      } catch (err) {
        console.log(err)
      }
  },
  // mounted () {
  //   const cable = ActionCable.createConsumer('ws://localhost:3001/cable')
  //   this.messageChannel = cable.subscriptions.create('RoomChannel', {
  //     connected: () => {
  //       this.getMessages()
  //       .then(() => {
  //         this.$refs.chatWindow.scrollToBottom()
  //       })
  //     },
  //     received: () => {
  //       this.getMessages()
  //       .then(() => {
  //         this.$refs.chatWindow.scrollToBottom()
  //       })
  //     }
  //   })
  // },
  // beforeUnmount () { 
  //   this.messageChannel.unsubscribe()
  // },
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
  },
  computed: {
    formattedMessages () {
      if (!this.messages.length) { return [] }
      return this.messages.map(message => {
        let time = formatDistanceToNow(new Date(message.created_at), { locale: ja })
        return { ...message, created_at: time }
      })
    }
  },  
}
</script>
