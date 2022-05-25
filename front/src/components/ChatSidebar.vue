<style scoped>
.chat-sidebar {
  border-right: 1px solid #f2f2f2;
  height: 100%;
  width: 20%;
  overflow-y: scroll;
}
.chat-room__detail {
  padding: 8px;
  background-color: #fff;
  cursor: pointer;
}
.chat-room__detail > .name {
  margin-bottom: 0.5rem;
}
</style>
<template>
  <div class="chat-sidebar">
    <div v-for="room in rooms" :key="room.id" class="chat-room">
      <div @click="openChatroom" class="chat-room__detail">
        <div class="name">{{ room.name }}</div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data(){
    return{
      rooms: [
        {
          id: 1,
          name: 'ramdom',
        },
        {
          id: 2,
          name: 'general',
        },
        {
          id: 3,
          name: 'memory',
        },
      ]
    }
  },
  methods: {
    openChatroom(){
      return null
    }
  },
}
</script>