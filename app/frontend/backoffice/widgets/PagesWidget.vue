<template lang="pug">
  sidebar-widget(:items="getPages.items", :is-loading="getPages.isLoading")
    template(slot="title") Страницы
    template(slot="item" slot-scope="{ item }")
      router-link.widget__item(:to="'/pages/' + item.id")
        h6(v-html="item.title || unnamed")
</template>

<script>
  import SidebarWidget from '../components/SidebarWidget.vue';
  import {mapGetters} from "vuex";
  export default {
    computed: {
      ...mapGetters(['getPages']),
      unnamed: () => '<i>(без названия)</i>'
    },
    components: { SidebarWidget }
  }
</script>

<style lang="scss">
  .widget__item {
    h6, p {
      margin-bottom: 0;
    }

    p {
      margin-top: 0.4em;
    }
  }
</style>
