<template lang="pug">
  sidebar-widget(:items="getLinks", :is-loading="getLinks.isLoading")
    template(slot="title") Ссылки
    template(slot="item" slot-scope="{ item }")
      router-link.widget__item(:to="'/links/' + item.id")
        h6(v-html="item.title || unnamed")
        p(v-html="item.description" v-show="item.description")
</template>

<script>
  import SidebarWidget from '../components/SidebarWidget.vue';
  import {mapGetters} from "vuex";
  export default {
    computed: {
      ...mapGetters(['getLinks']),
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
