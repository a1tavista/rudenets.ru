<script>
  import Sidebar from './components/Sidebar.vue';

  export default {
    data() {
      return {};
    },
    components: {Sidebar}
  }
</script>

<template lang="pug">
  .container
    sidebar
    transition(name="fade" mode="out-in")
      main.content-container
        router-view
</template>
