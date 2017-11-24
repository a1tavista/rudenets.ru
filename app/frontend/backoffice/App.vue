<script>
  import AppSidebar from './components/AppSidebar.vue';
  import {mapActions, mapGetters} from 'vuex';

  export default {
    data() {
      return {};
    },
    computed: {
      ...mapGetters(['isWidgetOpened'])
    },
    methods: {
      ...mapActions(['initializeApplicationData'])
    },
    mounted() {
      this.initializeApplicationData();
    },
    components: {AppSidebar}
  }
</script>

<template lang="pug">
  .container(:class="[!isWidgetOpened && 'container--tight']")
    app-sidebar
    transition(name="fade" mode="out-in")
      main.content-container
        router-view
</template>
