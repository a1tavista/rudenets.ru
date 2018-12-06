import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router);

import NoteFormView from '../views/NoteFormView.vue';
import LinkFormView from '../views/LinkFormView.vue';
import PageFormView from '../views/PageFormView.vue';
import NotepadView from '../views/NotepadView.vue';
import ImagesView from '../views/ImagesView.vue';
import createNoteFormView from "../views/createNoteFormView";

export default new Router({
  mode: 'history',
  base: '/cc',
  scrollBehavior: () => ({y: 0}),
  routes: [
    { path: '/', component: NotepadView },
    { path: '/notes/:id(\\d+)', component: NoteFormView },
    { path: '/notes/new', component: createNoteFormView("new") },
    { path: '/media/new', component: NoteFormView },
    { path: '/links/:id(\\d+)', component: LinkFormView },
    { path: '/pages/:id(\\d+)', component: PageFormView },
    { path: '/images', component: ImagesView },
  ]
})
