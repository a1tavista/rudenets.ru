<template>
  <div class='editor-block'>
    <el-input
      type="textarea"
      :value="value"
      autosize
      @input="onInput($event)"
      :autosize="{ minRows: 2 }"
      :tabindex='(200 + idx).toString()'
      class=''
    />
    <div class='editor-block__infobar'>
      Symbols: {{ value && value.length }}
      <template v-if="!lockType">
      | Type: {{ type }}
      <a
        v-for="type in otherTypes"
        :key="`editor-type-select-${idx}-${type}`"
        @click="onChangeType(type)"
      >
        | To {{ type }}
      </a>
      </template>
    </div>
  </div>
</template>

<script>

const BLOCK_TYPES = ['markdown', 'html'];
export default {
  props: {
    value: {
      type: String | null,
      required: true
    },
    type: {
      type: String,
      validator: value => BLOCK_TYPES.indexOf(value) !== -1,
      required: false,
      default: 'markdown'
    },
    lockType: {
      type: Boolean,
      required: false,
      default: false
    },
    idx: {
      type: Number,
      required: false
    }
  },
  computed: {
    otherTypes() {
      return BLOCK_TYPES.filter((a) => a !== this.type);
    }
  },
  methods: {
    onInput(value) {
      this.$emit('input', value);
    },
    onChangeType(type) {
      this.$emit('change-type', type);
    }
  }
};
</script>

<style lang="scss">
.editor-block {
  &__infobar {
    padding: 4px 0;
    font-family: Consolas, "Liberation Mono", Menlo, Courier, monospace;
    font-size: 12px;
    line-height: 1;
  }

  &__input {
    font-family: Consolas, "Liberation Mono", Menlo, Courier, monospace;
    font-size: 16px;
  }
}
</style>
