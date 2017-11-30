<template lang="pug">
  sidebar-widget(:items="getPublished.items", :is-loading="getPublished.isLoading")
    template(slot="title") Опубликованные
    template(slot="item" slot-scope="{ item }")
      router-link.widget__item(:to="'/bo/notes/' + item.id")
        h6(v-html="item.title || unnamed")
        p(v-html="item.summary" v-show="item.summary")
</template>

<script>
  import SidebarWidget from '../components/SidebarWidget.vue';
  import {mapGetters} from "vuex";
  export default {
    computed: {
      ...mapGetters(['getPublished']),
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
