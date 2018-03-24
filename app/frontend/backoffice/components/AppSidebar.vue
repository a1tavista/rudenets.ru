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

<template lang="pug">
  .sidebar
    .icon-sidebar
      div.icon-sidebar__group
        router-link.icon-sidebar__item(to="/")
          | Notes
      div.icon-sidebar__group
        router-link.icon-sidebar__item(to="/notes/new")
          | + Draft
      div.icon-sidebar__group
        button.icon-sidebar__item.icon-sidebar__item--widget(
          @click="openWidget('NotesWidget')"
          :class="[(currentWidget == 'NotesWidget') && 'active']")
          | Drafts

        button.icon-sidebar__item.icon-sidebar__item--widget(
          @click="openWidget('PostsWidget')"
          :class="[(currentWidget == 'PostsWidget') && 'active']")
          | Posts

        button.icon-sidebar__item.icon-sidebar__item--widget(
          @click="openWidget('LinksWidget')"
          :class="[(currentWidget == 'LinksWidget') && 'active']")
          | Links

        button.icon-sidebar__item.icon-sidebar__item--widget(
          @click="openWidget('LabelsWidget')"
          :class="[(currentWidget == 'LabelsWidget') && 'active']")
          | Tags

      div.icon-sidebar__group
        button.icon-sidebar__item.icon-sidebar__item--widget(
        @click="openWidget('PagesWidget')"
          :class="[(currentWidget == 'PagesWidget') && 'active']")
          | Pages

    aside(v-if="currentWidget" :is="currentWidget")
</template>
