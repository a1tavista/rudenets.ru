<template>
  <div>
    <el-collapse v-model="activePanes">
      <el-collapse-item title="Настройки обложки" name="1">
        <el-row :gutter="16">
          <el-col :span="10">
            <el-select placeholder="Режим работы" style='width: 100%' v-model='shapezatorSettings.mode'>
              <el-option
                  v-for="item in shapezatorOptions"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value" />
            </el-select>
          </el-col>
          <el-col :span="10">
            <el-input placeholder="Количество фигур" v-model='shapezatorSettings.shapesNumber' />
          </el-col>
          <el-col :span="4">
            <el-button type='primary' style='width: 100%' @click='generateCover' :loading="isShapezatorWorking">
              Сгенерировать
            </el-button>
          </el-col>
        </el-row>
        <el-row>

        </el-row>
      </el-collapse-item>
      <el-collapse-item title="Настройки SEO" name="2">
        <el-row><el-input placeholder="Мета-теги через запятую" /></el-row>
      </el-collapse-item>
      <el-collapse-item title="Настройки публикации" name="3">
        <el-row>
          <el-input placeholder="Ссылка для предпросмотра" :value='post.previewUrl' disabled>
            <div slot='prepend'>Ссылка для предпросмотра</div>
          </el-input>
        </el-row>
        <el-row>
          <el-button v-if='!post.entry.published' type='primary' @click='publishPost'>Опубликовать</el-button>
          <el-button v-if='post.entry.published' @click='unpublishPost'>Скрыть в черновики</el-button>
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
    isShapezatorWorking: false,
    shapezatorSettings: {
      shapesNumber: 600,
      mode: 0
    },
    shapezatorOptions: [
      { value: 0, label: 'Комбинированный' },
      { value: 1, label: 'Треугольники' },
      { value: 2, label: 'Прямоугольники' },
      { value: 3, label: 'Эллипсы' },
      { value: 4, label: 'Круги' },
      { value: 5, label: 'Прямоугольники с поворотом' },
      { value: 6, label: 'Кривые Безье' },
      { value: 7, label: 'Эллипсы с поворотом' },
      { value: 8, label: 'Полигоны' },
    ]
  }),
  methods: {
    ...mapActions([
      'updatePostField',
      'publishPost',
      'unpublishPost',
      'generatePostCover'
    ]),
    update(field, value) {
      this.updatePostField({ field, value });
    },
    generateCover() {
      this.isShapezatorWorking = true;
      this.generatePostCover({
        shapesNumber: this.shapezatorSettings.shapesNumber,
        mode: this.shapezatorSettings.mode
      }).then(() => this.isShapezatorWorking = false).catch(() => this.isShapezatorWorking = false)
    }
  },
  computed: {
    ...mapGetters({
      post: 'getCurrentPost'
    }),
  }
}
</script>
