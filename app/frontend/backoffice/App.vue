<template>
  <div>
    <el-container>
      <el-header class="header" height="80">
        <div class="header__content">
          <div class="header__main-heading">
            <h1 class="header__title">Редактор</h1>
          </div>
          <div class="header__links">
            <nav class="header__navigation">
              <router-link class="header__navigation-link" to="/posts">Посты</router-link>
              <router-link class="header__navigation-link" to="/channel">Канал</router-link>
              <router-link class="header__navigation-link" to="/links">Ссылки</router-link>
              <router-link class="header__navigation-link" to="/pages">Страницы</router-link>
              <router-link class="header__navigation-link" to="/images">Галерея</router-link>
            </nav>
          </div>
        </div>
      </el-header>
      <el-main>
        <router-view class="view" />
      </el-main>
    </el-container>
  </div>
</template>

<script>
import {mapActions, mapGetters} from 'vuex';

export default {
  data() {
    return {};
  },
  computed: {
    ...mapGetters(['isWidgetOpened'])
  },
  methods: {
    ...mapActions(['initializeApplicationData'])
  },
  mounted() {
    this.initializeApplicationData();
  }
}
</script>
