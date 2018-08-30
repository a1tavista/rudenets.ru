<template>
  <sidebar-widget :items="getLinks" :is-loading="getLinks.isLoading">
    <template slot="title">Ссылки</template>
    <template slot="item" slot-scope="{ item }">
      <router-link class="widget__item" :to="'/links/' + item.id">
        <h6 v-html="item.title || unnamed" />
        <p v-html="item.description" v-show="item.description" />
      </router-link>
    </template>
  </sidebar-widget>
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
