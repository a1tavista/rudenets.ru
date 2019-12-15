import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router);

import NoteFormView from '../views/PostFormView.vue';
import LinkFormView from '../views/LinkFormView.vue';
import PageFormView from '../views/PageFormView.vue';
import ImagesView from '../views/ImagesView.vue';
import createNoteFormView from "../views/createNoteFormView";
import RootView from "../views/RootView";
import PostsListView from "../views/PostsListView";

export default new Router({
  mode: 'history',
  base: '/cc',
  scrollBehavior: () => ({y: 0}),
  routes: [
    { path: '/', component: RootView },
    { path: '/posts', component: PostsListView },
    { path: '/posts/:id(\\d+)', component: NoteFormView },
    { path: '/posts/new', component: createNoteFormView("new") },
    { path: '/links/:id(\\d+)', component: LinkFormView },
    { path: '/pages/:id(\\d+)', component: PageFormView },
    { path: '/images', component: ImagesView },
  ]
})
