<template>
  <div>
    <el-collapse v-model="activePanes">
      <el-collapse-item title="Настройки публикации" name="1">
        <el-row>
          <el-input placeholder="Ссылка для предпросмотра" :value='post.previewUrl' disabled>
            <div slot='prepend'>Ссылка для предпросмотра</div>
          </el-input>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="10">
            <el-date-picker
                :value="post.publishedAt"
                @input="publicationSettings.publishingTime = $event"
                type="datetime"
                style="width: 100%"
                placeholder="Дата и время публикации" disabled>
            </el-date-picker>
          </el-col>
          <el-col :span="10">
            <el-input
                placeholder="Ссылка на пост"
                :value='post.slug'
                @input="publicationSettings.slug = $event" disabled>
              <div slot='prepend'>Ссылка на пост</div>
            </el-input>
          </el-col>
          <el-col :span="4">
            <el-button style="width: 100%" v-if='!post.published' type='primary' @click='publish'>Опубликовать</el-button>
          </el-col>
        </el-row>
      </el-collapse-item>
    </el-collapse>
  </div>
</template>

<script>
import {mapActions, mapGetters} from "vuex";

export default {
  data: () => ({
    activePanes: ['1'],
    publicationSettings: {
      slug: '',
      publishingTime: '',
      skipTelegram: false
    }
  }),
  methods: {
    ...mapActions([
      'updateChannelPostField',
      'publishChannelPost'
    ]),
    update(field, value) {
      this.updateChannelPostField({ field, value });
    },
    generateCover() {
      this.isShapezatorWorking = true;
      this.generateChannelPostCover({
        shapesNumber: this.shapezatorSettings.shapesNumber,
        mode: this.shapezatorSettings.mode
      }).then(() => this.isShapezatorWorking = false).catch(() => this.isShapezatorWorking = false)
    },
    publish() {
      this.publishChannelPost({
        slug: this.publicationSettings.slug,
        publishingTime: this.publicationSettings.publishingTime
      })
    }
  },
  computed: {
    ...mapGetters({
      post: 'getCurrentChannelPost'
    })
  }
}
</script>
