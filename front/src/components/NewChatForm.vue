<style scoped>
form {
  height: 15%;
  background-color: #fff;
  padding: 10px;
}
textarea {
  width: 100%;
  max-width: 100%;
  margin-bottom: 6px;
  padding: 10px;
  box-sizing: border-box;
  border: 0;
  border-radius: 20px;
  font-family: inherit;
  outline: none;
}
</style>
    
<template>
  <form>
    <textarea
      autofocus
      placeholder="メッセージを入力してEnterを押してください"
      v-model="message"
      @keydown.enter.meta.exact="handleSubmit"
    ></textarea>
  </form>
</template>

<script>
export default {
  emits: ['connectCable'],
  data () {
    return {
      message: ''
    }
  }  ,
  methods: {
    handleSubmit(e) {
      if (e.ctrlKey || e.metaKey) {
        this.$emit('connectCable', this.message)
        this.message = ""
      }
    }
  }
}
</script>

