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

<template lang="pug">
  div.toolbar
    slot(name="actions")
    .toolbar__group
      button(@click="changeState('isInputHidden', !state.isInputHidden)")
        i.material-icons {{ state.isInputHidden ? 'edit' : 'visibility' }}
      button(@click="changeState('isPreviewHidden', !state.isPreviewHidden)")
        i.material-icons {{ state.isPreviewHidden ? 'chrome_reader_mode' : 'web_asset' }}
      button(@click="changeState('isFullscreen', !state.isFullscreen)")
        i.material-icons {{ state.isFullscreen ? 'fullscreen_exit' : 'fullscreen' }}
</template>
