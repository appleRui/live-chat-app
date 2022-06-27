<style scoped>
form {
  border-top: 1px solid #eee;
  height: 15%;
  background-color: #fff;
  padding: 10px;
}
textarea {
  background-color: #f0f0f0;
  box-sizing: border-box;
  border: 0;
  border-radius: 10px;
  font-family: inherit;
  height: 95%;
  resize: none;
  outline: none;
  padding: 10px;
  max-width: 100%;
  width: 100%;
}

.full-screen {
  position: relative;
  top: -74%;
  height: 90vh;
}
</style>
    
<template>
  <form :class="[isFullScreenTextarea ? 'full-screen' : '']">
    <v-btn text icon tile class="d-flex ml-auto" @click="chengeTextAreaHeight">
      <v-icon>{{ screenIcon }}</v-icon>
    </v-btn>
    <textarea
      autofocus
      placeholder="メッセージを入力してcmd+enter送信してください"
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
      message: '',
      isFullScreenTextarea: false,
      screenIcon: "mdi-fullscreen"
    }
  }  ,
  methods: {
    handleSubmit(e) {
      if (e.ctrlKey || e.metaKey) {
        this.$emit('connectCable', this.message)
        this.message = ""
        if(this.isFullScreenTextarea) this.chengeTextAreaHeight()
      }
    },
    chengeTextAreaHeight() {
      this.isFullScreenTextarea = !this.isFullScreenTextarea
      this.screenIcon = this.isFullScreenTextarea ? 'mdi-fullscreen-exit' : 'mdi-fullscreen'
    }
  }
}
</script>