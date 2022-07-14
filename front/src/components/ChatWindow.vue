<style scoped>
.chat-window {
  height: 74%;
  background: white;
  padding: 30px 20px;
}
ul {
  list-style: none;
  margin: 0;
  padding: 0;
}
ul li {
  display: inline-block;
  clear: both;
}
.received .message {
  background: #eee;
  padding: 8px;
  display: inline-block;
  border-radius: 10px;
  margin-bottom: 2px;
  max-width: 400px;
}
.received {
  float: left;
}
.sent {
  float: right;
}
.sent .message {
  background: #677bb4;
  color: white;
  padding: 8px;
  display: inline-block;
  border-radius: 10px;
  margin-bottom: 2px;
  max-width: 400px;
}
.name {
  position: relative;
  margin-right: 6px;
  display: block;
  font-size: 0.6rem;
}
.created-at {
  display: block;
  color: #999;
  font-size: 0.6rem;
  margin-bottom: 8px;
  margin-left: 4px;
}
.messages {
  height: 100%;
  overflow: auto;
  font-size: 0.8rem;
  white-space: pre-line;
}
</style>

<template>
  <div class="chat-window">
    <div v-if="messages" class="messages" ref="messages">
      <ul v-for="message in messages" :key="message.id">
        <li
          :class="{
            received: message.email !== uid,
            sent: message.email === uid,
          }"
        >
          <span class="name">{{ message.name }}</span>
          <span class="message">{{ message.content }}</span>
          <span class="created-at">{{ message.created_at }}前</span>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import { getUid } from "@/services/localStorage"

export default{
  props: ['messages'],
  data () {
    return {
      uid: getUid()
    }
  },
  methods: {
    scrollToBottom () {
      const element = this.$refs.messages
      element.scrollTop = element.scrollHeight
    }
  },
}
</script>
