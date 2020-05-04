<template>
  <div class="field">
    <input v-model="value" :id="id" :type="type" required @input="input" />
    <label :for="id" :data-title="label" />
  </div>
</template>

<script>
import uuid from 'uuid-random'

export default {
  props: {
    type: {
      type: String,
      required: true,
    },
    label: {
      type: String,
      required: true,
    },
    value: { },
  },
  data: () => ({
    id: uuid(),
  }),
  methods: {
    input (e) {
      this.$emit('input', e.target.value)
    },
  },
}
</script>

<style scoped lang="sass">
.label-before
  line-height: 20px
  font-size: 12px
  top: -10px
  background: #fff
  padding: 0 4px
  left: 9px

.field
  position: relative
  margin-bottom: 10px

  label::before
    content: attr(data-title)
    position: absolute
    top: 0
    left: 10px
    line-height: 33px
    font-size: 14px
    color: #777
    transition: 300ms all
    cursor: text

  input
    width: 100%
    line-height: 30px
    padding: 0 10px
    font-size: 14px
    color: #222
    border: 1px solid #ccc
    border-radius: 3px

    // Look into https://css-tricks.com/float-labels-css/#article-header-id-5
    &:focus
      outline: 0
      border-color: blue
    &:valid + label::before
      @extend .label-before
      content: attr(data-title)
    &:focus + label::before
      @extend .label-before
      content: attr(data-title)
      color: blue
</style>
