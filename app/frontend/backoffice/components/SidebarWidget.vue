<template>
  <div class="widget">
    <header class="widget__header">
      <h1 class="widget__title">
        <slot name="title"/>
      </h1>
      <button class="widget__close" @click="closeWidget">
        <i class="material-icons">close</i>
      </button>
    </header>
    <div class="widget__spinner" v-if="isLoading">
      <spinner size="huge" />
    </div>
    <div class="widget__list" v-else>
      <slot name="item" v-for="item in items" :item="item"/>
    </div>
  </div>
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
