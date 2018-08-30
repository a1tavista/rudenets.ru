<template>
  <div class="container" :class="[!isWidgetOpened && 'container--tight']">
    <app-sidebar />
    <main class="content-container">
      <router-view />
    </main>
  </div>
</template>

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
