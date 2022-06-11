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
      <ChatSidebar
        @openChatroom="openChatroom"
        :chatrooms="formattedChatRooms"
      />
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
  mounted () {
    const cable = ActionCable.createConsumer('ws://localhost:3001/cable')
    this.messageChannel = cable.subscriptions.create('RoomChannel', {
      connected: () => {
        const lastOpenRoomId = this.$cookie.get('lastOpenChat')
        if(lastOpenRoomId != null){
          this.getMessages(lastOpenRoomId)
          .then(() => {
            this.$refs.chatWindow.scrollToBottom()
          })
        }
      },
      received: () => {
        const lastOpenRoomId = this.$cookie.get('lastOpenChat')
        this.getMessages(lastOpenRoomId).then(() => {
          this.$refs.chatWindow.scrollToBottom()
        })
      }
    })
          // while (true) {
          //   setTimeout(() => {
          //     console.log("更新")
          //   }, 1000)
          // }
  },
  beforeUnmount () { 
    this.messageChannel.unsubscribe()
  },
  methods: {
    async getMessages(room_id) {
      try {
        const res = await axios.get('http://localhost:3001/messages', {
          headers: {
            uid: window.localStorage.getItem('uid'),
            "access-token": window.localStorage.getItem('access-token'),
            client:window.localStorage.getItem('client')
          },
          params: {
            id: room_id
          }
        })
        if (!res) {
          new Error('メッセージ一覧を取得できませんでした')
        }
        this.messages = res.data
        this.savedLastOpenRoom(room_id)
      } catch (err) {
        console.error(err.message)
      }
    },
    connectCable (message) {
      this.messageChannel.perform('receive', {
        message: message,
        email: window.localStorage.getItem('uid'),
        room_id: this.$cookie.get('lastOpenChat')
      })
    },
    openChatroom(room_id){
      this.getMessages(room_id).then(() => {
        this.$refs.chatWindow.scrollToBottom()
      })
    },
    savedLastOpenRoom(room_id){
      return this.$cookie.set('lastOpenChat', room_id, 60)
    }
  },
  computed: {
    formattedMessages () {
      if (!this.messages.length) { return [] }
      return this.messages.map(message => {
        let time = formatDistanceToNow(new Date(message.created_at), { locale: ja })
        return { ...message, created_at: time }
      })
    },
    formattedChatRooms () {
      if (!this.chatrooms.length) { return [] }
      return this.chatrooms.map(room => {
        let time = formatDistanceToNow(new Date(room.timestamp), { locale: ja })
        return { ...room, created_at: time }
      })
    },
  },
}
</script>
