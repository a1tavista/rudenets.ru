<template>
  <div>
    <lifetime-grid
      :start-date="new Date(1994,12,27)"
      :end-date="new Date(2094,12,27)"
    />
  </div>
</template>

<script>
import LifetimeGrid from "../../common/components/LifetimeGrid";

export default {
  components: {LifetimeGrid},
}
</script>
