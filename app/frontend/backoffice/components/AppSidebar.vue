<template>
  <div>
    <div class="icon-sidebar">

      <div class="icon-sidebar__group">
        <router-link class="icon-sidebar__item" to="/notes/new">+ Draft</router-link>
      </div>

      <div class="icon-sidebar__group">
        <button
          class="icon-sidebar__item icon-sidebar__item--widget"
          @click="openWidget('DraftsWidget')"
          :class="[(currentWidget === 'DraftsWidget') && 'active']"
        >Drafts</button>

        <button
          class="icon-sidebar__item icon-sidebar__item--widget"
          @click="openWidget('PostsWidget')"
          :class="[(currentWidget === 'PostsWidget') && 'active']"
        >Posts</button>

        <button
          class="icon-sidebar__item icon-sidebar__item--widget"
          @click="openWidget('LinksWidget')"
          :class="[(currentWidget === 'LinksWidget') && 'active']"
        >Links</button>

        <button
          class="icon-sidebar__item icon-sidebar__item--widget"
          @click="openWidget('PagesWidget')"
          :class="[(currentWidget === 'PagesWidget') && 'active']"
        >Pages</button>
      </div>
    </div>
    <aside v-if="currentWidget" :is="currentWidget" />
  </div>
</template>

<script>
  import DraftsWidget from '../widgets/DraftsWidget.vue';
  import PostsWidget from '../widgets/PostsWidget.vue';
  import LinksWidget from '../widgets/LinksWidget.vue';
  import PagesWidget from '../widgets/PagesWidget.vue';
  import {mapActions, mapGetters} from "vuex";

  export default {
    data: () => {
      return {};
    },
    computed: {
      ...mapGetters(['currentWidget'])
    },
    methods: {
      ...mapActions(['openWidget'])
    },
    components: {DraftsWidget, PostsWidget, LinksWidget, PagesWidget}
  }
</script>
