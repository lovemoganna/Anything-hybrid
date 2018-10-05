<template lang="pug">
    .container
        .tab
            .tab-item
                router-link(to='/littleSisters') 小姐姐
            .tab-item
                router-link(to='/test') 测试
        router-view
</template>
<script type="text/ecmascript-6">
    export default {
    }
</script>
<style>

</style>