import NoteFormView from './PostFormView.vue'
import ChannelPostFormView from './ChannelPostFormView.vue'

export function createNoteFormView (type) {
  return {
    render (h) {
      return h(NoteFormView, { props: { type }})
    }
  }
}

export function createChannelPostFormView (type) {
  return {
    render (h) {
      return h(ChannelPostFormView, { props: { type }})
    }
  }
}
