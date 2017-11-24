<template lang="pug">
  div.widget
    header.widget__header
      h1.widget__title
        slot(name="title")
      button.widget__close(@click="closeWidget")
        i.material-icons close
    .widget__spinner(v-if="isLoading")
      spinner(size="huge")
    .widget__list(v-else)
      slot(name="item" v-for="item in items" :item="item")
</template>

<script>
  import Spinner from 'vue-simple-spinner';
  import {mapActions} from "vuex";

  export default {
    props: {
      items: {
        required: true,
        type: Array
      },
      isLoading: {
        default: false
      }
    },
    data() {
      return {};
    },
    methods: {
      ...mapActions(['closeWidget'])
    },
    components: { Spinner }
  }
</script>
