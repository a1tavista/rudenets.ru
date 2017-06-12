<script>
  export default {
    methods: {
      changeState(option, value) {
        this.$emit('stateChanging', { param: option, value: value });
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
    }

    &__separator {
      margin: 0.4em 0.6em 0.2em;
      border-left: 1px solid black;
    }
  }
</style>

<template lang="pug">
  div.toolbar
    .toolbar__group
      button(@click="")
        i.material-icons {{ state.isFullscreen ? 'edit' : 'visibility' }}
      button(@click="")
        i.material-icons {{ state.isPreviewHidden ? 'chrome_reader_mode' : 'web_asset' }}
      button(@click="changeState('isFullscreen', !state.isFullscreen)")
        i.material-icons {{ state.isFullscreen ? 'fullscreen_exit' : 'fullscreen' }}
    .toolbar__separator
    .toolbar__group
      button(@click="")
        i.material-icons {{ state.isPreviewHidden ? 'chrome_reader_mode' : 'web_asset' }}
      button(@click="")
        i.material-icons {{ state.isFullscreen ? 'fullscreen_exit' : 'fullscreen' }}
    .toolbar__separator
</template>
