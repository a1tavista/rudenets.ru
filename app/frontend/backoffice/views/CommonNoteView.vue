<template lang="pug">
  .note-editing-form.note-editing-form--fullscreen
    .note-editing-form__header
      h3.note-editing-form__header-title Блокнот
      .note-editing-form__header-actions
        button Скачать
    .note-editing-form__wrapper
      markdown-editor.editor--x-large.editor--single(
        placeholder='Полный текст заметки'
        :value="text"
        :is-preview-hidden="true"
      )
</template>

<script>
  import MarkdownEditor from '../components/editor/MarkdownEditor.vue';

  export default {
    data: () => ({
      text: ''
    }),
    components: {MarkdownEditor}
  }
</script>
