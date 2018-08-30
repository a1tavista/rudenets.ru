<template>
  <sidebar-widget :items="getLabels" :is-loading="getLabels.isLoading">
    <template slot="title">Метки</template>
    <template slot="item" slot-scope="{ item }">
      <router-link class="widget__item" :to="'/notes/' + item.id">
        {{ item.name }}
      </router-link>
    </template>
  </sidebar-widget>
</template>

<script>
  import SidebarWidget from '../components/SidebarWidget.vue';
  import {mapGetters, mapState} from "vuex";
  export default {
    computed: {
      ...mapGetters(['getLabels'])
    },
    components: { SidebarWidget }
  }
</script>
