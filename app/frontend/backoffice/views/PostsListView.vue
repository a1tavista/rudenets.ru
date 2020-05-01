<template>
  <div v-loading="getDrafts.isLoading">
    <el-card class='el-card_margin-bottom' header="Черновики">
      <el-table :data="getDrafts.items" style="width: 100%; border: 0" :show-header="false">
        <el-table-column label="Дата публикации" width="250">
          <template slot-scope="scope">
            <i class="el-icon-time"></i>
            <span style="margin-left: 10px">{{ scope.row.updatedAtLocalized }}</span>
          </template>
        </el-table-column>
        <el-table-column label="Название" width="">
          <template slot-scope="scope">
            <router-link class="widget__item" :to="'/posts/' + scope.row.id">
              {{ scope.row.title || unnamed }}
            </router-link>
          </template>
        </el-table-column>
        <el-table-column align="right" width="200">
          <template slot-scope="scope">
            <el-button
              size="mini"
              @click="$router.push({ path: '/posts/' + scope.row.id })">Редактировать</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <el-card class='el-card_margin-bottom' header="Опубликованные">
      <el-table :data="getPublished.items" style="width: 100%; border: 0" :show-header="false">
        <el-table-column label="Дата публикации" width="250">
          <template slot-scope="scope">
            <i class="el-icon-time"></i>
            <span style="margin-left: 10px">{{ scope.row.updatedAtLocalized }}</span>
          </template>
        </el-table-column>
        <el-table-column label="Название">
          <template slot-scope="scope">
            <router-link class="widget__item" :to="'/posts/' + scope.row.id">
              {{ scope.row.title || unnamed }}
            </router-link>
            <div style='font-size: 12px;'>Опубликовано {{ scope.row.publishedAtLocalized }}</div>
          </template>
        </el-table-column>
        <el-table-column align="right" width="200">
          <template slot-scope="scope">
            <el-button
              size="mini"
              @click="$router.push({ path: '/posts/' + scope.row.id })">Редактировать</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  computed: {
    ...mapGetters(['getDrafts', 'getPublished']),
    unnamed: () => '<i>(без названия)</i>'
  },
}
</script>
