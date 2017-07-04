import NoteFormView from './NoteFormView.vue'

export default function createNoteFormView (type) {
  return {
    render (h) {
      return h(NoteFormView, { props: { type }})
    }
  }
}
