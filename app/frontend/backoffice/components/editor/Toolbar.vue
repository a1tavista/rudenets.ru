<template>
  <div class="toolbar">
    <slot name="actions" />
    <div class="toolbar__group">
      <button @click="changeState('isInputHidden', !state.isInputHidden)">
        <i class="material-icons">{{ state.isInputHidden ? 'edit' : 'visibility' }}</i>
      </button>
      <button @click="changeState('isPreviewHidden', !state.isPreviewHidden)">
        <i class="material-icons">{{ state.isPreviewHidden ? 'vertical_split' : 'subject' }}</i>
      </button>
      <button @click="changeState('isFullscreen', !state.isFullscreen)">
        <i class="material-icons">{{ state.isFullscreen ? 'fullscreen_exit' : 'fullscreen' }}</i>
      </button>
    </div>
  </div>
</template>

<script>
  export default {
    methods: {
      changeState(option, value) {
        var payload = {};
        payload[option] = value;
        this.$emit('stateChanging', payload);
      }
    },
    props: ['state']
  }
</script>

<style lang="scss" scoped>
  .toolbar {
    display: flex;
    flex-direction: row;

    &__group {
      display: flex;
      flex-direction: row;
      align-items: center;
    }

    &__spacer {
      flex: 1;
    }

    &__separator {
      margin: 0.4em 0.6em 0.2em;
      border-left: 1px solid black;
    }
  }
</style>


