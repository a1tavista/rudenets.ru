<script>
  import LabelsWidget from '../widgets/LabelsWidget.vue';
  import NotesWidget from '../widgets/NotesWidget.vue';
  import PostsWidget from '../widgets/PostsWidget.vue';
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
    components: {NotesWidget, PostsWidget, LabelsWidget}
  }
</script>

<template lang="pug">
  .sidebar
    .icon-sidebar
      div.icon-sidebar__group
        router-link.icon-sidebar__item(to="/bo/notes/new")
          i.material-icons note_add
      div.icon-sidebar__group
        button.icon-sidebar__item.icon-sidebar__item--widget(
          @click="openWidget('NotesWidget')"
          :class="[(currentWidget == 'NotesWidget') && 'active']")
          i.material-icons description

        button.icon-sidebar__item.icon-sidebar__item--widget(
          @click="openWidget('PostsWidget')"
          :class="[(currentWidget == 'PostsWidget') && 'active']")
          i.material-icons present_to_all

        button.icon-sidebar__item.icon-sidebar__item--widget(
          @click="openWidget('LabelsWidget')"
          :class="[(currentWidget == 'LabelsWidget') && 'active']")
          i.material-icons label

    aside(v-if="currentWidget" :is="currentWidget")
</template>
