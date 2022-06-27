<style scoped>
.chat-header {
  align-items: center;
  border-bottom: 1px solid #eee;
  display: flex;
  justify-content: space-between;
  padding: 1rem 2.5rem;
}
.name {
  font-size: 18px;
  font-weight: bold;
  margin: 0;
}
.member {
  font-size: 14px;
  margin: 0;
}
</style>

<template>
  <div class="chat-header">
    <p class="name">{{ room.name }}</p>
    <!-- <p class="member">{{ room.member }}人のメンバーが参加しています</p> -->
  </div>
</template>

<script>
export default {
  props: ['room']
}
</script>