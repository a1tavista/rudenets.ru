<template>
  <div class="grid" >
    <app-sidebar class="grid__sidebar" :style="!isWidgetOpened && 'grid-column: small-sidebar;'" />
    <main class="grid__view" :style="isWidgetOpened && 'grid-column: small-content;'">
      <router-view class="view" />
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
