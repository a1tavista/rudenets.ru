<template>
  <sidebar-widget :items="getPages" :is-loading="getPages.isLoading">
    <template slot="title">Страницы</template>
    <template slot="item" slot-scope="{ item }">
      <router-link class="widget__item" :to="'/pages/' + item.id">
        <h6 v-html="item.title || unnamed"/>
      </router-link>
    </template>
  </sidebar-widget>
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
