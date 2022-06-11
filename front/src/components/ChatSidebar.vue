<style scoped>
.chat-sidebar {
  border-right: 1px solid #f2f2f2;
  height: 100%;
  width: 20%;
  overflow-y: scroll;
}
.chat-room__detail {
  height: 75px;
  padding: 8px;
  background-color: #fff;
  cursor: pointer;
}
.chat-room__detail:hover {
  background-color: #f2f2f2;
  transition: 0.5s;
}
.chat-room__detail > .name {
  margin-bottom: 0.5rem;
  font-weight: bold;
  font-size: 17px;
}
.chat-room__detail > .last-message {
  margin-bottom: 0.5rem;
  font-size: 12px;
}
</style>

<template>
  <div class="chat-sidebar">
    <div v-for="room in chatrooms" :key="room.id" class="chat-room">
      <div @click="$emit('openChatroom', room.id)" class="chat-room__detail">
        <div class="name">{{ room.name }}</div>
        <div class="last-message">{{ room.last_message }}</div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  props: ['chatrooms'],
}
</script>