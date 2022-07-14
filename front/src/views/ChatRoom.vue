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
        <ChatHeader :room="room" />
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
import http from '@/services/http'
import ChatHeader from '../components/ChatHeader'
import ChatWindow from '../components/ChatWindow'
import ChatSidebar from '@/components/ChatSidebar.vue'
import Systembar from '@/components/Systembar.vue'
import NewChatForm from '../components/NewChatForm'
import { formatDistanceToNow } from 'date-fns'
import { ja } from 'date-fns/locale'
import { getUid } from '@/services/localStorage'

export default {
  components: { Systembar, ChatSidebar, ChatWindow, ChatHeader, NewChatForm },
  data () {
    return {
      chatrooms: [],
      messages: [],
      room: {},
    }
  },
  async created() {
    setInterval(() => { this.interval() }, 3000)
    try {
      const { data } = await http.get('/rooms')
      this.chatrooms = data
      } catch (err) {
        console.log(err)
    }
  },
  mounted () {
    const cable = ActionCable.createConsumer('ws://localhost:3001/cable')
    this.messageChannel = cable.subscriptions.create('RoomChannel', {
      connected: () => {
        const lastOpenRoomId = this.$cookie.get('lastOpenChat')
        if (lastOpenRoomId != null) {
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
  },
  beforeUnmount () { 
    this.messageChannel.unsubscribe()
  },
  methods: {
    async interval() {
      const { data } = await http.get('/rooms')
      this.chatrooms = data
    },
    async getMessages(room_id) {
      try {
        await this.getRoom(room_id)
        const { data } = await http.get('/messages', {
          params: {
            id: room_id
          }
        })
        if (!data) {
          new Error('メッセージの取得に失敗しました\nリロードしてください')
        }
        this.messages = data
        this.savedLastOpenRoom(room_id)
      } catch (err) {
        console.error(err.message)
      }
    },
    async getRoom(room_id) {
      try {
        const { data } = await http.get('/rooms/' + room_id)
        if (!data) {
          alert('ルーム情報の取得に失敗しました\nリロードしてください')
        }
        this.room = data
        this.savedLastOpenRoom(room_id)
      } catch (err) {
        console.error(err.message)
      }
    },
    connectCable (message) {
      this.messageChannel.perform('receive', {
        message: message,
        email: getUid(),
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
  }
}
</script>
