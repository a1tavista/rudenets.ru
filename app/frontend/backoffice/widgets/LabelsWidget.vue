<template lang="pug">
  sidebar-widget(:items="getLabels.items", :is-loading="getLabels.isLoading")
    template(slot="title") Метки
    template(slot="item" slot-scope="{ item }")
      router-link.widget__item(:to="'/bo/notes/' + item.id") {{ item.name }}
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
