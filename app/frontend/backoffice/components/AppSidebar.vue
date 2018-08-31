<template>
  <div>
    <div class="icon-sidebar">

      <div class="icon-sidebar__group">
        <router-link class="icon-sidebar__item" to="/">Notes</router-link>
      </div>

      <div class="icon-sidebar__group">
        <router-link class="icon-sidebar__item" to="/notes/new">+ Draft</router-link>
      </div>

      <div class="icon-sidebar__group">
        <button
          class="icon-sidebar__item icon-sidebar__item--widget"
          @click="openWidget('NotesWidget')"
          :class="[(currentWidget === 'NotesWidget') && 'active']"
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
          @click="openWidget('LabelsWidget')"
          :class="[(currentWidget === 'LabelsWidget') && 'active']"
        >Tags</button>

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
  import LabelsWidget from '../widgets/LabelsWidget.vue';
  import NotesWidget from '../widgets/NotesWidget.vue';
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
    components: {NotesWidget, PostsWidget, LabelsWidget, LinksWidget, PagesWidget}
  }
</script>
