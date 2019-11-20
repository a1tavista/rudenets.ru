<template>
  <sidebar-widget :items="getDrafts.items" :is-loading="getDrafts.isLoading">
    <template slot="title">Черновики</template>
    <template slot="item" slot-scope="{ item }">
      <router-link class="widget__item" :to="'/notes/' + item.id">
        <h6 v-html="item.title || unnamed"/>
        <p v-html="item.summary"  v-show="item.summary"/>
      </router-link>
    </template>
  </sidebar-widget>
</template>

<script>
  import SidebarWidget from '../components/SidebarWidget.vue';
  import {mapGetters} from "vuex";
  export default {
    computed: {
      ...mapGetters(['getDrafts']),
      unnamed: () => '<i>(без названия)</i>'
    },
    components: { SidebarWidget }
  }
</script>
