<script>
  import PostForm from './components/PostForm.vue';

  export default {
    data() {
      return {
        kek: "lol"
      };
    },
    components: {PostForm}
  }
</script>

<template lang="pug">
  .container
    .sidebar
      .icon-sidebar
        div.icon-sidebar__group
          .icon-sidebar__item
            i.material-icons note_add
          .icon-sidebar__item
            i.material-icons add_a_photo
          .icon-sidebar__item
            i.material-icons playlist_add
        div.icon-sidebar__group
          .icon-sidebar__item
            i.material-icons language
          .icon-sidebar__item
            i.material-icons link
        div.icon-sidebar__group
          .icon-sidebar__item
            i.material-icons description
          .icon-sidebar__item
            i.material-icons insert_photo
          .icon-sidebar__item
            i.material-icons label
          .icon-sidebar__item
            i.material-icons code
      aside.widget
        header.widget__header
          h1.widget__title Заметки
        .widget__list
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
          .widget__item Ссылка
    div

</template>
