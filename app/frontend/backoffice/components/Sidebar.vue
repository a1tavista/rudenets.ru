<script>
  import InteractiveWidget from '../widgets/InteractriveWidget.vue';
  import MediaWidget from '../widgets/MediaWidget.vue';
  import LabelsWidget from '../widgets/LabelsWidget.vue';
  import NotesWidget from '../widgets/NotesWidget.vue';

  export default {
    data() {
      return {
        currentWidget: "NotesWidget"
      };
    },
    components: {InteractiveWidget, MediaWidget, NotesWidget, LabelsWidget}
  }
</script>

<template lang="pug">
  .sidebar
    .icon-sidebar
      div.icon-sidebar__group
        router-link.icon-sidebar__item(to="/")
          i.material-icons note_add
        .icon-sidebar__item
          i.material-icons add_a_photo
        .icon-sidebar__item
          i.material-icons playlist_add
      div.icon-sidebar__group
        router-link.icon-sidebar__item(to="/bo/published-notes")
          i.material-icons language
        router-link.icon-sidebar__item(to="/bo/published-links")
          i.material-icons link
      div.icon-sidebar__group
        button.icon-sidebar__item(@click="currentWidget = 'NotesWidget'")
          i.material-icons description
        button.icon-sidebar__item(@click="currentWidget = 'MediaWidget'")
          i.material-icons insert_photo
        button.icon-sidebar__item(@click="currentWidget = 'LabelsWidget'")
          i.material-icons label
        button.icon-sidebar__item(@click="currentWidget = 'InteractiveWidget'")
          i.material-icons code
    aside.widget(:is="currentWidget")
</template>
