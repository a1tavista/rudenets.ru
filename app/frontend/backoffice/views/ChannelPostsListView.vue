<template>
  <div>
    <el-row>
      <el-page-header @back="$router.push({ path: '/' })" content="Telegram-канал" />
    </el-row>
    <div v-loading="getChannelDrafts.isLoading">
      <el-card class='el-card_margin-bottom'>
        <div slot="header">
          Черновики (<router-link class="widget__item" :to="'/channel/new'">новый пост</router-link>)
        </div>
        <el-table :data="getChannelDrafts.items" style="width: 100%; border: 0" :show-header="false">
          <el-table-column label="Дата изменения" width="250">
            <template slot-scope="scope">
              <i class="el-icon-time"></i>
              <span style="margin-left: 10px">{{ scope.row.updatedAtLocalized }}</span>
            </template>
          </el-table-column>
          <el-table-column label="che">
            <template slot-scope="scope">
              <router-link class="widget__item" :to="'/channel/' + scope.row.id">{{ scope.row.title }}</router-link>
            </template>
          </el-table-column>
          <el-table-column align="right" width="200">
            <template slot-scope="scope">
              <el-button
                size="mini"
                @click="$router.push({ path: '/channel/' + scope.row.id })">Редактировать</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-card>

      <el-card class='el-card_margin-bottom' header="Опубликованные">
        <el-table :data="getChannelPublished.items" style="width: 100%; border: 0" :show-header="false">
          <el-table-column label="Дата публикации" width="250">
            <template slot-scope="scope">
              <i class="el-icon-time"></i>
              <span style="margin-left: 10px">{{ scope.row.publishedAtLocalized }}</span>
            </template>
          </el-table-column>
          <el-table-column label="Название поста">
            <template slot-scope="scope">
              <router-link class="widget__item" :to="'/channel/' + scope.row.id">
                {{ scope.row.title }}
                <span v-html="unnamed" v-if="!scope.row.title"></span>
              </router-link>
            </template>
          </el-table-column>
        </el-table>
      </el-card>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  computed: {
    ...mapGetters(['getChannelDrafts', 'getChannelPublished']),
    unnamed: () => '<i>(без названия)</i>'
  },
}
</script>
